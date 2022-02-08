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

The demo grid is a temperature-gravity grid of low-resolution
intensity spectra (based on the solar-metallicity
:ads_citet:`Castelli:2003` atmospheres), useful for learning about
MSG's capabilities. Download the grid from :grid:`here <sg-demo.h5>`
(its size is around 40 MB); you should store it in the same directory
as where you plan to run Jupyter (or Python).

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

   # Load the SpecGrid

   sg = pymsg.SpecGrid('sg-demo.h5')

This object has a number of (read-only) properties that tell us about
the parameter space spanned by the grid:

.. jupyter-execute::

   # Inspect grid parameters

   print('Grid parameters:')

   for i, axis_label in enumerate(sg.axis_labels):
      print(f'  {axis_label} ({sg.axis_min[i]} -> {sg.axis_max[i]})')

   print(f'  lam ({sg.lam_min} -> {sg.lam_max})')
      
Here, ``logT`` and ``logg`` correspond (respectively) to the
:math:`\log_{10}(\Teff/\kelvin)` and
:math:`\log_{10}(g/\cm\,\second^{-2})` atmosphere parameters, while
``lam`` is wavelength :math:`\lambda` in :math:`\angstrom`.

Plotting the Flux
=================

Armed with this knowledge, we're now in a position to evaluate and
plot a flux spectrum for Sirius. First, let's store atmosphere
parameters for the star in a dict called ``dx``:

.. jupyter-execute::

   # Set atmosphere parameters dict

   dx = {'logT': np.log10(9940.), 'logg': 4.33}

(these data are taken from `Wikipedia's` :wiki:`Sirius` entry). Then
set up a wavelength abcissa for a spectrum spanning the visible range,
:math:`3,000\,\angstrom` to :math:`7,000\,\angstrom`.

.. jupyter-execute::

   # Set up the wavelength abscissa

   lam_min = 3000.
   lam_max = 7000.

   lam = np.linspace(lam_min, lam_max, 501)

   lam_c = 0.5*(lam[1:] + lam[:-1])

Here, the array ``lam`` defines the boundaries of 500 wavelength bins
:math:`\{\lambda_{i},\lambda_{i+1}\}` (:math:`i=1,\ldots,500`) and the
array ``lam_c`` stores the central wavelength of each bin.

With all our parameters defined, let's now evaluate and plot the flux
spectrum using a call to the :py:func:`pymsg.SpecGrid.flux` function:

.. jupyter-execute::

   # Evaluate the flux

   F_lam = sg.flux(dx, lam)

   # Plot

   plt.figure(figsize=[8,8])
   plt.plot(lam_c, F_lam)

   plt.xlabel(r'$\lambda ({\AA})$')
   plt.ylabel(r'$F_{\lambda}\ ({\rm erg\,cm^{-2}\,s^{-1}}\,\AA^{-1})$')
   
This looks about right --- we can clearly see the Balmer series,
starting with H\ :math:`\alpha` at :math:`6563\,\angstrom`.

Plotting the Intensity
======================

Sometimes we want to know the specific intensity of the radiation
emerging from a star's atmosphere; an example might be when we're
modeling eclipse or transit phenomena, which requires detailed
knowlege of the stellar-surface radiation field. For this, we can use
the :py:func:`pymsg.SpecGrid.intensity` function.

Here's a demonstration of this function in action, plotting the
specific intensity across the H\ :math:`\alpha` line profile for ten
different values of the cosine :math:`\mu=0.1,0.2,\ldots,1.0` of the
emergence angle (relative to the surface normal):

.. jupyter-execute::

   # Set up the wavelength abscissa

   lam_min = 6300.
   lam_max = 6800.

   lam = np.linspace(lam_min, lam_max, 100)

   lam_c = 0.5*(lam[1:] + lam[:-1])

   # Loop over mu

   plt.figure(figsize=[8,8])

   for mu in np.linspace(1.0, 0.1, 10):

       # Evaluate the intensity

       I_lam = sg.intensity(dx, mu, lam)

       # Plot

       if mu==0.1 or mu==1.0:
           label=r'$\mu={:3.1f}$'.format(mu)
       else:
           label=None

       plt.plot(lam_c, I_lam, label=label)

   plt.xlabel(r'$\lambda ({\AA})$')
   plt.ylabel(r'$I_{\lambda}\ ({\rm erg\,cm^{-2}\,s^{-1}}\,\AA^{-1}\,srad^{-1})$')

   plt.legend()

We can clearly see that limb-darkening in the line core is much weaker
than in the continuum --- exactly what we expect from such a strong
line.

.. rubric:: Footnotes

.. [#memory] Behind the scenes, the grid data is loaded on demand; see XXX for further details.
