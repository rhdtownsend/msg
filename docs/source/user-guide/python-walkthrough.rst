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
size is around 18 MB); you should store it in the same directory as
where you plan to run Jupyter (or Python).

The PyMSG Module
================

To use MSG from Python, first make sure the :envvar:`MSG_DIR`
environment variable is set, as described in the :ref:`quick-start`
chapter. Then, fire up Jupyter, create a new notebook, and paste the
following statements into the first cell:

.. jupyter-execute::

   # Import pymsg

   import sys
   import os
   sys.path.insert(0, os.path.join(os.environ['MSG_DIR'], 'lib'))
   import pymsg

   # Import standard modules and configure them

   import numpy as np
   import matplotlib.pyplot as plt

   %matplotlib inline
   plt.rcParams.update({'font.size': 16})

The first four statements take care of importing the :py:mod:`pymsg`
module, which provides the Python interface to MSG. We also take the
liberty of importing standard modules such as :py:mod:`matplotlib` and
:py:mod:`numpy`.

Loading & Inspecting the Grid
=============================

The next step is to load the demo grid into memory [#memory]_, by
creating a new :py:class:`pymsg.SpecGrid` object:

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

   print('Spectral abcissa parameters:')
   print(f'  w_0: {sg.w_0}')
   print(f'   dw: {sg.dw}')
   print(f'  n_w: {sg.n_w}')

The ``logT`` and ``logg`` atmosphere parameters are familiar enough,
corresponding (respectively) to :math:`\log_{10}(\Teff/\kelvin)` and
:math:`\log_{10}(g/\cm\,\second^{-2})`. However, what are those three
'spectral abscissa' parameters? In brief, MSG represents the abscissa
(x-axis) of spectra using

.. math:: w \equiv \log(\lambda/\angstrom)

instead of the usual wavelength :math:`\lambda`. Moreover, it divides
spectra up into a sequence of bins with uniform width in
:math:`w`-space. For a collection of ``n_w`` such bins, the
:math:`k`'th bin (:math:`k = 1,\ldots,{\tt n\_w}`) spans the interval
:math:`[w_{k}, w_{k+1}]`, where

.. math:: w_{k} \equiv {\tt w\_0} + (k-1)\, {\tt dw}

The detailed rationale for these choices are discussed in the
:ref:`spectral-abscissa` chapter. For now, note that the bin width
:math:`{\tt dw}` is directly connected to the resolution :math:`R` of
the spectrum via

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
let's set up spectral abcissa parameters for a spectrum running from
3,000 to 7,000 Angstroms:

.. jupyter-execute::

   # Set wavelength bounds

   lambda_min = 3000.
   lambda_max = 7000.

   # Set up corresponding w bounds

   w_min = np.log(lambda_min)
   w_max = np.log(lambda_max)

   # Set up spectral abscissa parameters

   w_0 = w_min
   dw = sg.dw
   n_w = np.ceil((w_max - w_min)/dw)

Note that we don't get to choose the bin width ``dw`` --- it's
constrained to be the same as the bin width ``sg.dw`` of the ``sg``
object. This may seem overly restrictive, but there are ways to change
the latter; see the XXXX section.

With all our parameters defined, let's now evaluate and plot the flux
spectrum using a call to the :py:func:`pymsg.SpecGrid.flux` function:

.. jupyter-execute::

   # Evaluate the center wavelength of the bins

   lambda_c = np.exp(w_0 + 0.5*dw + np.arange(n_w)*dw)

   # Evaluate the flux; note the parameters!

   F_w = sg.flux(dx, w_0, n_w)

   # Convert flux from per-unit-w to per-unit-lambda

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
emerging from a star's atmosphere; an example might be when we're
modeling eclipse or transit phenomena, when we need to know the angle
dependence of the local radiation field. For this, we can use the
:py:func:`pymsg.SpecGrid.intensity` function.

Here's a demonstration of this function in action, plotting the
specific intensity for ten different values of the cosine
:math:`mu=0.1,0.2,\ldots,1.0` of the emergence angle (relative to the
surface normal):

.. jupyter-execute::

   # Set wavelength bounds

   lambda_min = 6300.
   lambda_max = 6800.

   # Set up corresponding w bounds

   w_min = np.log(lambda_min)
   w_max = np.log(lambda_max)

   # Set up spectral abscissa parameters

   w_0 = w_min
   dw = sg.dw
   n_w = np.ceil((w_max - w_min)/dw)

   # Evaluate the center wavelength of the bins

   lambda_c = np.exp(w_0 + 0.5*dw + np.arange(n_w)*dw)

   # Loop over mu

   plt.figure(figsize=[8,8])

   for mu in np.linspace(1.0, 0.1, 10):

       # Evaluate the intensity; note the parameters!

       I_w = sg.intensity(dx, mu, w_0, n_w)

       # Convert intensity from per-unit-w to per-unit-lambda

       I_lambda = I_w/lambda_c

       # Plot

       if mu==0.1 or mu==1.0:
           label=r'$\mu={:3.1f}$'.format(mu)
       else:
           label=None

       plt.plot(lambda_c, I_lambda, label=label)

   plt.xlabel(r'$\lambda ({\AA})$')
   plt.ylabel(r'$I_{\lambda} ({\rm erg\,cm^{-2}\,s^{-1}}\,\AA^{-1}\,srad^{-1})$')

   plt.legend()

The plot focuses on the H\ :math:`\alpha` line, and we can clearly see
that limb-darkening in the line core is much weaker than in the
continuum --- exactly what we expect from such a strong line.

Changing the Resolution
=======================

Although the :py:func:`pymsg.SpecGrid.flux` and
:py:func:`pymsg.SpecGrid.intensity` functions are constrained to adopt
the same bin size/resolution as the underlying
:py:func:`pymsg.Specgrid` object, it's possible to change the spectral
abscissa parameters when the object is first created. This is done by
passing values for the parameters to the constructor (TBD)

.. rubric:: Footnotes

.. [#memory] In fact, MSG is a bit smarter than that; it only loads
             data into memory when they are needed.




