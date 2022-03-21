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

Preparation
===========

Before starting Jupyter, ensure that recent versions of the `NumPy
<https://numpy.org/>`__, `Matplotlib <https://matplotlib.org/>`__ and
`Astropy <https://www.astropy.org/>`__ packages are installed on your
system. Also, make sure that the :envvar:`MSG_DIR` environment
variable is set as described in the :ref:`quick-start` chapter.

Importing the PyMSG Module
==========================

Launch Jupyter, create a new Python3 notebook, and paste the following
statements into the first cell:

.. jupyter-execute::

   # Import standard modules

   import sys
   import os
   import numpy as np
   import astropy.constants as con
   import matplotlib.pyplot as plt

   # Set paths & import pymsg

   MSG_DIR = os.environ['MSG_DIR']

   sys.path.insert(0, os.path.join(MSG_DIR, 'lib'))
   import pymsg

   # Set plot parameters

   %matplotlib inline
   plt.rcParams.update({'font.size': 16})

The `sys.path.insert` statement adds the directory
:file:`$MSG_DIR/lib` to the search path, allowing Python to find and
import the :py:mod:`pymsg` module. This module provides the Python
interface to MSG.

Loading & Inspecting the Demo Grid
==================================

For demonstration purposes MSG includes a low resolution specgral
grid, stored in the file :file:`$MSG_DIR/data/grids/sg-demo.h5`
[#grids]_. Load this demo grid into memory [#memory]_.  by creating a
new :py:class:`pymsg.SpecGrid` object:

.. jupyter-execute::

   # Load the SpecGrid

   GRID_DIR = os.path.join(MSG_DIR, 'data', 'grids')

   specgrid_file_name = os.path.join(GRID_DIR, 'sg-demo.h5')

   specgrid = pymsg.SpecGrid(specgrid_file_name)

This object has a number of (read-only) properties that tell us about
the parameter space spanned by the grid:

.. jupyter-execute::

   # Inspect grid parameters

   print('Grid parameters:')

   for label in specgrid.axis_labels:
      print(f'  {label} ({specgrid.axis_min[label]} -> {specgrid.axis_max[label]})')

   print(f'  lam ({specgrid.lam_min} -> {specgrid.lam_max})')
      
Here, ``logT`` and ``logg`` correspond (respectively) to the
:math:`\log_{10}(\Teff/\kelvin)` and
:math:`\log_{10}(g/\cm\,\second^{-2})` atmosphere parameters, while
``lam`` is wavelength :math:`\lambda/\angstrom`.

Plotting the Flux
=================

With the grid loaded, let's evaluate and plot a flux spectrum for
Sirius. First, store atmosphere parameters for the star in a dict:

.. jupyter-execute::

   # Set atmosphere parameters dict

   x_vec = {'logT': np.log10(9940.), 'logg': 4.33}

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

With all our parameters defined, evaluate the flux spectrum using a
call to the :py:meth:`pymsg.SpecGrid.flux` method, and then plot it:

.. jupyter-execute::

   # Evaluate the flux

   F_lam = specgrid.flux(x_vec, lam)

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
the :py:meth:`pymsg.SpecGrid.intensity` method.

Here's a demonstration of this method in action, plotting the specific
intensity across the H\ :math:`\alpha` line profile for ten different
values of the cosine :math:`\mu=0.1,0.2,\ldots,1.0` of the emergence
angle (relative to the surface normal):

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

       I_lam = specgrid.intensity(x_vec, mu, lam)

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

Evaluating Magnitudes & Colors
==============================

As a final step in this walkthrough, let's evaluate the magnitude and
colors of Sirius in the Johnson system. We can do this by creating a
new :py:class:`pymsg.PhotGrid` object for each passband:

.. jupyter-execute::

   # Load the PhotGrids

   PASS_DIR = os.path.join(MSG_DIR, 'data', 'passbands')
   filters = ['U', 'B', 'V']

   photgrids = {}

   for filter in filters:
      passband_file_name = os.path.join(PASS_DIR, f'pb-Generic-Johnson.{filter}-Vega.h5')
      photgrids[filter] = pymsg.PhotGrid(specgrid_file_name, passband_file_name)

(for convenience, we store the :py:class:`pymsg.PhotGrid` objects in a
dict, keyed by filter name).  In the calls to the object constructor
:py:meth:`pymsg.PhotGrid`, the first argument is the name of a
spectral grid (i.e., the demo grid), and the second argument is the
name of a passband definition file; a limited set of these files is
provided in the :file:`$MSG_DIR/data/passbands` subdirectory
[_passbands]. The normalized *surface* fluxes of Sirius are then be
found using the :py:meth:`pymsg.PhotGrid.flux` method:

.. jupyter-execute::
   
   # Evaluate the surface fluxes (each normalized to the passband
   # zero-point flux)

   F_surf = {}

   for filter in filters:
      F_surf[filter] = photgrids[filter].flux(x_vec)

To convert these into apparent magnitudes, we first dilute them to
Earth fluxes using the inverse-square law, and then apply
:wiki:`Pogson's <N._R._Pogson>` logarithmic formula:

.. jupyter-execute::

   # Set the radius and distance to Sirius

   R = 1.711 * con.R_sun
   d = 2.670 * con.pc

   # Evaluate the Earth fluxes

   F = {}

   for filter in filters:
      F[filter] = F_surf[filter]*R**2/d**2

   # Evaluate apparent magnitudes and print out magnitude & color

   mags = {}

   for filter in filters:
      mags[filter] = -2.5*np.log10(F[filter])

   print(f"V={mags['V']}, U-B={mags['U']-mags['B']}, B-V={mags['B']-mags['V']}")
   
Reassuringly, the resulting values are within 10 mmag of Sirius'
apparent magnitude and color (again, as given by the Wikipedia entry).

.. rubric:: Footnotes

.. [#grids] Larger grids can be downloaded separately from MSG; see
            the :ref:`spectral-grids` appendix.
	    
.. [#passbands] Passband definition files for other
                instruments/photometric systems can be downloaded
                separately from MSG; see the :ref:`passband-files`
                appendix.
	    
.. [#memory] Behind the scenes, the grid data is loaded on demand; see
             XXX for further details.
