.. _python-wallthrough:

******************
Python Walkthrough
******************

This chapter provides a walkthrough of using the MSG Python interface
to evaluate intensity and flux spectra for a model of Sirius (alpha
Canis Majoris). The code fragments are presented as a sequence of
Jupyter notebook cells, but pasting all of the fragments into a Python
script should work also.

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

To use MSG from Python, you need to import the `pymsg` module. As the
first cell in a Jupyter notebook, paste in the following statements:

.. jupyter-execute::

   import sys
   import os
   sys.path.insert(0, os.path.join(os.environ['MSG_DIR'], 'lib'))

   import matplotlib.pyplot as plt
   import pymsg

   %matplotlib inline

Here, we take the liberty of also importing standard modules such as
`matplotlib`. Note that the first three lines are necessary so that
Python can find the `pgmsg` module in :file:`${MSG_DIR}/lib`.

Loading & Inspecting the Grid
=============================

The next step is to load
the demo grid into memory [#memory]_, by creating a new
:py:class:`SpecGrid` object:

.. jupyter-execute::

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
is considered constant.

.. rubric:: Footnotes

.. [#memory] In fact, MSG is a bit smarter than that; it only loads
             data into memory when they are needed.




