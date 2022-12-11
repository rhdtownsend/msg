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
   grid-tools/ascii_to_specint.rst
   grid-tools/specint_to_specint.rst

If you would like to convert spectra from a format that isn't covered by
these tools, please :git:`open an issue <rhdtownsend/msg/issues>`
describing the format and/or pointing to relevant literature.

   
Packaging Grids
---------------

The following tools package multiple :f-schema:`specint` files to
create :f-schema:`specgrid` and :f-schema:`photgrid` files:

.. toctree::
   :maxdepth: 2

   grid-tools/specint_to_specgrid.rst
   grid-tools/specgrid_to_photgrid.rst

	
.. _creating-passbands:

Creating Passband Files
-----------------------

The following tools create :f-schema:`passband` files:

.. toctree::
   :maxdepth: 2

   grid-tools/make_passband.rst
