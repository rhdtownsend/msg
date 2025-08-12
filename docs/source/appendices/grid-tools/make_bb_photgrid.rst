.. _grid-tools-make_bb_photgrid:

make_bb_photgrid
~~~~~~~~~~~~~~~~

.. program:: make_bb_photgrid

Synopsis
--------

.. code-block:: text

   make_bb_photgrid PHOTGRID_FILE [options]

Description
-----------

The :program:`make_bb_photgrid` creates a grid of blackbody
intensities (either bolometric or monochromatic), and writes it to a
:f-schema:`photgrid` file.

Options
-------

.. option:: -h, --help

   Print a summary of options.

.. option:: --logT-min=MIN

   Minimum :math:`\log(T)` value.

.. option:: --logT-max=MAX

   Maximum :math:`\log(T)` value.

.. option:: --n-logT=N

   Number of :math:`\log(T)` values.

.. option:: --u-limb=U

   Linear limb-darkening parameter.

.. option:: --lambda=VALUE

   Wavelength of monochromatic intensity. If not specified, then bolometric
   intensities are calculated. 

.. option:: -l --grid-label=NAME

   Set the grid label.
