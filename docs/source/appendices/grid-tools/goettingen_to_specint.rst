.. _grid-tools-goettingen_to_specint:

goettingen_to_specint
~~~~~~~~~~~~~~~~~~~~~

.. program:: goettingen_to_specint

Synopsis
--------

.. code-block:: text

   goettingen_to_specint <input_file_name> <output_file_name> [options]

Description
-----------

The :command:`goettingen_to_specint` tool extracts a flux spectrum
from a data file in FITS format (with the schema described by
:ads_citealp:`husser:2013`), and writes it to a
:f-schema:`specint` file.

Options
-------

.. option:: --file-type <type>

   Type of input file. This determines the wavelength abscissa adopted
   for the input file. Valid choices, corresponding to the different
   grids described by :ads_citet:`husser:2013`, are :code:`HiRes`
   (high-resolution; default), :code:`MedRes-A1` (medium-resolution,
   :math:`\Delta \lambda = 1\,\angstrom`) and :code:`MedRes-R10000`
   (medium resolution, :math:`\mathcal{R}=10\,000`).

.. note::

   In order for :command:`goettingen_to_specint` to build, you must
   first uncomment/edit the line in :file:`$MSG_DIR/build/Makefile`
   that defines the `FITS_LDFLAGS` variable. This variable defines the
   flags used to link against your system's FITS library.
