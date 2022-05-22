.. _grid-tools:

**********
Grid Tools
**********

This appendix outlines the set of tools provided with MSG to assist in
creating and managing custom grids. These tools are built during
compilation when the :envvar:`TOOLS` enivoronment variable is set to
`yes` (see the :ref:`Installation` chapter for further details); once
built, they can be found in the :file:`$MSG_DIR/bin` directory.


Extracting Spectra
------------------

MSG spectroscopic grids are built from a set of HDF5 `specint`
(spectroscopic intensity) files containing individual spectra at the
grid nodes. These files are themselves extracted from pre-calculated
grids, with a variety of supported formats as discussed in each of the
following sections.

SYNSPEC
~~~~~~~

The :command:`synspec_to_specint` tool extracts an single intensity
spectrum from a :file:`fort.18` data file produced by the SYNSPEC
spectral synthesis package :ads_citep:`lanz:2003`, and writes it to an
`specint` file. This tool accepts the following command-line arguments:

.. program:: synspec_to_specint

.. option:: <synspec_file_name>

   Name of input file.	      

.. option:: <n_mu>

   Number of :math:`\mu` values in input file (as specified
   in the :file:`fort.55` SYNSPEC control file).

.. option:: <mu_0>

   Minimum :math:`\mu` value in input file (as specified in the
   :file:`fort.55` SYNSPEC control file).

.. option:: <lam_min>

   Minimum wavelength in output file.

.. option:: <lam_max>

   Maximum wavelength in output file.

.. option:: <R>

   Resolution :math:`\mathcal{R}=\lambda/\Delta\lambda` in output file.

.. option:: <law_str>
     
   Limb-darkening law in output file (see the
   :ref:`limb-darkening-laws` section for a list of options).

.. option:: <specint_file_name>

   Name of output file.

.. option:: <label> (optional)

   Label of atmosphere parameter (must be accompanied by a
   corresponding :option:`<value>` argument).

.. option:: <value> (optional)

   Lalue of atmosphere parameter (must be accompanied by a
   corresponding :option:`<label>` argument).

Note that :option:`<label>` and :option:`<value>` parameters must be
paired; and that there can be multiple of these pairs.

FERRE
~~~~~

The :command:`ferre_to_specint` tool extracts a series of flux spectra
from a data file in FERRE format (see the `FERRE User Guide
<http://www.as.utexas.edu/~hebe/ferre/ferre.pdf>`__), and writes them
to `specint` files. This tool accepts the following command-line
arguments:

.. program:: ferre_to_specint

.. option:: <ferre_file_name>

   Name of input file.

.. option:: <ferre_file_type>

   Type of input file. This determines the mapping between atmospheric
   parameters given in the input file, and atmospheric parameters
   written to the output file. Supported options are: 'CAP18' (for the
   :ads_citealp:`allende:2018` grids).

.. option:: <specint_file_name>

   Name of output file.

Goettingen
~~~~~~~~~~

The :command:`goettingen_to_specint` tool extracts a flux spectrum
from a data file in FITS format (with the schema described by
:ads_citealp:`husser:2013`), and writes it to a `specint`
file. This tool accepts the following command-line arguments:

.. program:: goettingen_to_specint

.. option:: <fits_file_name>

   Name of input file.

.. option:: <wave_type>

   Type of wavelength abscissa. This determines the number and
   distribution of points to assume for the input file. Supported
   options, corresponding to the different grids described by
   :ads_citet:`husser:2013`, are: 'HiRes' (high-resolution),
   'MedRes-A1' (medium-resolution, :math:`\Delta \lambda =
   1\,\angstrom`) and 'MedRes-R10000' (medium resolution,
   :math:`\mathcal{R}=10\,000`).  grids),

.. option:: <specint_file_name>

   Name of output file.


Modifying Spectra
-----------------

The spectra contained in HDF5 `specint` files (as produced by one of
the tools above) can be subsetted and/or rebinned using the
:command:`specint_to_specint` tool. This tool accepts the following
command-line arguments:

.. program:: specint_to_specint

.. option:: <specint_file_name_in>

   Name of input file.

.. option:: <specint_file_name>

   Name of output file.

.. option:: lam_min=<value> (optional)

   Subset to have a minimum wavelength of at least `<value>`.

.. option:: lam_max=<value> (optional)

   Subset to have a maximum wavelength of at most `<value>`.

.. option:: R=<value> (optional)

   Rebin to have a uniform resolution :math:`\mathcal{R}` of `<value>`.

.. option:: dlam=<value> (optional)

   Rebin to have a uniform wavelength spacing :math:`\Delta \lambda` of `<value>`.

.. option:: just=<L|R> (optional)

   Justify the new wavelength abscissa to the left ('L') or right ('R').

   
.. _creating-spec-grids:

Creating Spectroscopic Grids
----------------------------

With a set of spectrum files extracted, an HDF5 `specgrid`
(spectroscopic grid) file can be created using the
:command:`specint_to_specgrid` tool. This tool accepts the following
command-line arguments:

.. program:: specint_to_specgrid

.. option:: <manifest_file_name>

   Name of input manifest file (see below).

.. option:: <specgrid_file_name>

   Name of output file.

.. option:: <allow_dupes> (optional)

   Flag governing handling of duplicate grid nodes in the manifest
   file; set to 'T' to allow duplicates.

The manifest file is a simple text file that lists all the `specint`
files that should be included in the grid.


.. _creating-phot-grids:

Creating Photometric Grids
--------------------------

Given a `specgrid` file, a corresponding HDF5
`photgrid` (photometric grid) file can be built using the
`specgrid_to_photgrid` tool. This tool accepts the following
command-line arguments:

.. program:: specgrid_to_photgrid

.. option:: <specgrid_file_name>

   Name of input file.

.. option:: <passband_file_name>

   Name of passband file.

.. option:: <photgrid_file_name>

   Name of output file.

Note that it's not always necessary to create `photgrid` files, as MSG
can convolve with passbands on the fly (as discussed in the
:ref:`photometric-colors` section).
 
      
