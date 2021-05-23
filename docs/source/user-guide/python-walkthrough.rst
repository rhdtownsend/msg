.. _python-wallthrough:

******************
Python Walkthrough
******************

This chapter provides a walkthrough of using the MSG Python interface
to evaluate flux and intensity spectra for a model of Sirius
(:math:`\alpha` Canis Majoris). The code fragments are presented as a
sequence of Jupyter notebook cells, but pasting all of the fragments
into a Python script should work also.

.. _python-walkthrough-grid:

The Demo Grid
=============

The demo grid is a small, low-resolution temperature-gravity grid of
intensity spectra, useful for learning about MSG's
capabilities. Download the grid from :grid:`here <sg-demo.h5>` (its
size is around 18 MB); you can store it in any directory, but make a
note of where you've put it.

The PyMSG Module
================

To use MSG from Python, you need to import the :py:mod:`pymsg` module. As the
first cell in a Jupyter notebook, paste in the following statements:

.. jupyter-execute::

   import sys
   import os
   sys.path.insert(0, os.path.join(os.environ['MSG_DIR'], 'lib'))

   import numpy as np
   import matplotlib.pyplot as plt
   import pymsg

   %matplotlib inline

   plt.rcParams.update({'font.size': 16})   

Here, we take the liberty of also importing standard modules such as
:py:mod:`matplotlib` and :py:mod:`numpy`. Note that the first three lines are necessary so that
Python can find the :py:mod:`pgmsg` module in :file:`${MSG_DIR}/lib`.

Loading & Inspecting the Grid
=============================

The next step is to load
the demo grid into memory [#memory]_, by creating a new
:py:class:`pymsg.SpecGrid` object:

.. jupyter-execute::

   # Create a new SpecGrid

   sg = pymsg.SpecGrid('sg-demo.h5')

This object has a number of (read-only) properties that tell us about
the parameter space covered by the grid:

.. jupyter-execute::

   print('Atmosphere parameters:')
   for i, axis_label in enumerate(sg.axis_labels):
      print(f'  {axis_label} ({sg.axis_minima[i]} -> {sg.axis_maxima[i]})')

   print()

   print('Spatial abcissa:')
   print(f'  w_0: {sg.w_0}')
   print(f'   dw: {sg.dw}')
   print(f'  n_w: {sg.n_w}')

The ``logT`` and ``logg`` atmosphere parameters are familiar enough,
corresponding (respectively) to :math:`\log_{10}(\Teff/\kelvin)` and
:math:`\log_{10}(g/\cm\,\second^{-2})`. However, what are those three
'spatial abcissa' values? This question goes to the heart of how MSG
represents spectral quantities --- both internally, but also when
returning them as a result. For reasons of efficiency, MSG adopts a
spatial (wavelength) abscissa comprising a set of bins distributed
uniformly in :math:`w`-space, where

.. math:: w \equiv \log(\lambda/\angstrom)

For a collection of ``n_w`` bins, the bounds of the :math:`k`'th bin are given by

.. math:: {\tt w\_0} + (k - 1) \times {\tt dw} \leq w \leq {\tt w\_0} + k \times {\tt dw} \qquad (k = 0,\ldots,{\tt n\_w}-1)

Across a given bin, a spectral quantity (e.g., the specific intensity)
is considered constant. Note that the bin width :math:`{\tt dw}` is
directly connected to the resolution :math:`R` of the spatial abscissa
via

.. math:: R = \frac{1}{\tt dw}.
	  

Plotting the Flux
=================

Armed with this knowledge, we're now in a position to evaluate and
plot a flux spectrum for Sirius. First, let's store atmosphere
parameters for the star in a dict called ``dx``:

.. jupyter-execute::

   # Set atmosphere parameters dict

   dx = {'logT': np.log10(9940.), 'logg': 4.33}

(these data are taken from `Wikipedia's` :wiki:`Sirius` entry). Then,
let's evaluate spatial abcissa parameters for a spectrum running from
3,000 to 7,000 Angstroms:

.. jupyter-execute::

   # Set wavelength bounds

   lambda_min = 3000.
   lambda_max = 7000.

   # Set up corresponding w bounds

   w_min = np.log(lambda_min)
   w_max = np.log(lambda_max)

   # Evaluate spatial abcissa values

   w_0 = w_min
   dw = sg.dw
   n_w = np.ceil((w_max - w_min)/dw)

Note that we don't get to choose the bin width ``dw`` --- it's
constrained to be the same as the bin width ``sg.dw`` of the ``sg``
object. This may seem overly restrictive, but there are ways to change
the latter; see the XXXX section.

With all our parameters defined, let's now evaluate and plot the flux
spectrum:

.. jupyter-execute::

   # Evaluate the center wavelength of the bins

   lambda_c = np.exp(w_0 + 0.5*dw + np.arange(n_w)*dw)

   # Evaluate the flux

   F_w = sg.flux(dx, w_0, n_w)

   # Convert flux units from per-unit-w to per-unit-lambda

   F_lambda = F_w/lambda_c

   # Plot

   plt.figure(figsize=[8,8])
   plt.plot(lambda_c, F_lambda)

   plt.xlabel(r'$\lambda ({\AA})$')
   plt.ylabel(r'$F_{\lambda} ({\rm erg\,cm^{-2}\,s^{-1}}\,\AA^{-1})$')
   

This looks about right --- we can clearly see the Balmer series,
starting with H\ :math:`\alpha` at :math:`6563\,\angstrom`.

Plotting the Intensity
======================

Sometimes we need to know the specific intensity of the radiation
emerging from a star's atmosphere (an example is modeling eclipse or transit phenomena, when there is a direct probe of 

.. rubric:: Footnotes

.. [#memory] In fact, MSG is a bit smarter than that; it only loads
             data into memory when they are needed.




