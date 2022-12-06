.. _grid-tools:

**********
Grid Tools
**********

This appendix outlines the set of tools provided with MSG to assist in
creating and managing custom grids. These tools are built by default
during compilation, and can be found in the :file:`$MSG_DIR/bin`
directory.


Converting Spectra
------------------

The following tools convert existing spectra and/or spectroscopic
grids into one or more :f-schema:`specint` files:

.. toctree::
   :maxdepth: 2

   grid-tools/synspec_to_specint.rst
   grid-tools/ferre_to_specint.rst
   grid-tools/goettingen_to_specint.rst
   grid-tools/specint_to_specint.rst

   
Building Grids
--------------

The following tools package multiple :f-schema:`specint` files to
create :f-schema:`specgrid` and :f-schema:`photgrid` files:

.. toctree::
   :maxdepth: 2

   grid-tools/specint_to_specgrid.rst
   grid-tools/specgrid_to_photgrid.rst

	
.. _creating-passbands:

Creating Passband Files
-----------------------

Additional :f-schema:`passband` files (beyond those already provided in the
:ref:`passband-files` appendix) can be created using the
:command:`make_passband` tool. This tool accepts the following
command-line arguments:

.. program:: make_passband

.. option:: <table_file_name>

   Name of input file (see below).

.. option:: <F_0>

   Normalizing flux :math:`F_{0}` (:math:`\erg\,\cm^{-2}\,\second^{-1}\,\angstrom^{-1}`).

.. option:: <passband_file_name>

   Name of output :f-schema:`passband` file.

The input file is a text file tabulating wavelength :math:`\lambda`
(:math:`\angstrom`) and passband response function
:math:`S'(\lambda)` (see the :ref:`photometric-colors` section).
