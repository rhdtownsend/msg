.. _grid-tools-goettingen_to_specint:

goettingen_to_specint
~~~~~~~~~~~~~~~~~~~~~

The :command:`goettingen_to_specint` tool extracts a flux spectrum
from a data file in FITS format (with the schema described by
:ads_citealp:`husser:2013`), and writes it to a
:fileref:`specint` file. This tool accepts the following
command-line arguments:

.. program:: goettingen_to_specint

.. option:: <fits_file_name>

   Name of input FITS file.

.. option:: <wave_type>

   Type of wavelength abscissa. This determines the number and
   distribution of points to assume for the input file. Supported
   options, corresponding to the different grids described by
   :ads_citet:`husser:2013`, are: 'HiRes' (high-resolution),
   'MedRes-A1' (medium-resolution, :math:`\Delta \lambda =
   1\,\angstrom`) and 'MedRes-R10000' (medium resolution,
   :math:`\mathcal{R}=10\,000`).

.. option:: <specint_file_name>

   Name of output :fileref:`specint` file.

.. note::

   In order for :command:`goettingen_to_specint` to build, you must
   first uncomment/edit the line in :file:`$MSG_DIR/build/Makefile`
   that defines the `FITS_LDFLAGS` variable. This variable defines the
   flags used to link against your system's FITS library.
