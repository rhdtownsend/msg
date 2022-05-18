.. _grid-files:

**********
Grid Files
**********

Due to their large size and gradually evolving content (as
improvements are made), grid files are not shipped as part of the
:git:`rhdtownsend/msg` git repository; they must be downloaded
separately (the sole exception is the demo grid,
:file:`$MSG_DIR/data/grids/sg-demo.h5`). This chapter describes the
various grids currently available, and discusses how custom grids can
be created.

.. _grid-files-CAP18:

CAP18 Grids
===========

The CAP18 grids are based on the data published in
:ads_citet:`allende:2018` (the letters 'CAP' are the initials of the
first author). They contain flux spectra only (no intensity data), and
are as follows:

.. list-table::
   :header-rows: 1	
   :widths: 30 10 10 50
	 
   * - File
     - Resolution
     - :math:`\lambda` Range
     - Atmospheric Parameters
   * - :grids:`sg-CAP18-large.h5 <CAP18/sg-CAP18-large.h5>` (72GB)
     - :math:`R=10\,000`
     - :math:`[1\,300, 65\,000]\,\angstrom`
     - :math:`\Teff`, :math:`\log g`, :math:`[\FeH]`, :math:`[\aFe]`, :math:`\log \xi`
   * - :grids:`sg-CAP18-coarse.h5 <CAP18/sg-CAP18-coarse.h5>` (340MB)
     - :math:`R=10\,000`
     - :math:`[1\,300, 65\,000]\,\angstrom`
     - :math:`\Teff`, :math:`\log g`, :math:`[\FeH]`
   * - :grids:`sg-CAP18-high.h5 <CAP18/sg-CAP18-high.h5>` (2.9GB)
     - :math:`R=100\,000`
     - :math:`[1\,300, 65\,000]\,\angstrom`
     - :math:`\Teff`, :math:`\log g`, :math:`[\FeH]`
   * - :grids:`sg-CAP18-ultra.h5 <CAP18/sg-CAP18-ultra.h5>` (5.2GB)
     - :math:`R=300\,000`
     - :math:`[1\,300, 65\,000]\,\angstrom`
     - :math:`\Teff`, :math:`\log g`, :math:`[\FeH]`

The ranges of the atmospheric parameters are as follows:

* effective temperature :math:`\Teff \in [3\,500, 30\,000]\,\kelvin`
* surface gravity :math:`\log g \in [0.0, 5.0]\,\text{cgs dex}`
* metallicity :math:`[\FeH] \in [-5.0, 0.5]\,\text{dex}`
* alpha enhancement :math:`[\aFe] \in [-1.0,1.0]\,\text{dex}`
* microturbulent velocity :math:`\log \xi \in [-0.301,0.903]\,\text{cgs dex}`

.. _grid-files-Göttingen:

Göttingen Grids
===============

The Göettingen grids are based on the data described in
:ads_citet:`husser:2013` and available for download from
`phoenix.astro.physik.uni-goettingen.de
<https://phoenix.astro.physik.uni-goettingen.de/>`__. They contain
flux spectra only (no intensity data), and are as follows:

.. list-table::
   :header-rows: 1	
   :widths: 30 10 10 50
	 
   * - File
     - Resolution
     - :math:`\lambda` Range
     - Atmospheric Parameters
   * - :grids:`sg-Goettingen-HiRes.h5 <Goettingen/sg-Goettingen-HiRes.h5>` (116GB)
     - variable
     - :math:`[500, 55\,000]\,\angstrom`
     - :math:`\Teff`, :math:`\log g`, :math:`[\FeH]`, :math:`[\aFe]`
   * - :grids:`sg-Goettingen-MedRes-A.h5 <Goettingen/sg-Goettingen-MedRes-A.h5>` (5.9GB)
     - :math:`\Delta \lambda = 1\,\angstrom` |br| (:math:`10\times` oversampled)
     - :math:`[3\,000, 10\,000]\,\angstrom`
     - :math:`\Teff`, :math:`\log g`, :math:`[\FeH]`, :math:`[\aFe]`
   * - :grids:`sg-Goettingen-MedRes-R.h5 <Goettingen/sg-Goettingen-MedRes-R.h5>` (17GB)
     - :math:`R=10,000` |br| (:math:`10\times` oversampled)
     - :math:`[3\,000, 25\,000]\,\angstrom`
     - :math:`\Teff`, :math:`\log g`, :math:`[\FeH]`, :math:`[\aFe]`

The ranges of the atmospheric parameters are as follows:

* effective temperature :math:`\Teff \in [2\,300, 12\,000]\,\kelvin`
* surface gravity :math:`\log g \in [0.0, 6.0]\,\text{cgs dex}`
* metallicity :math:`[\FeH] \in [-4.0, 1.0]\,\text{dex}`
* alpha enhancement :math:`[\aFe] \in [-0.2,1.2]\,\text{dex}`

Custom Grids
============

A set of tools is provided with MSG to assist in creating and managing
custom grids. These tools are built during compilation when the
:envvar:`TOOLS` enivoronment variable is set to `yes` (see the
:ref:`Installation` chapter for further details).

Extracting Spectra
------------------

Spectra suitable for use by MSG can be extracted using one of the
following tools:

* :command:`synspec_to_specint` --- extract a single intensity
  spectrum from a data file produced by SYNSPEC
  :ads_citep:`lanz:2003`.

* :command:`ferre_to_specint` --- extract a series of flux spectra
  from a data file in `FERRE
  <http://www.as.utexas.edu/~hebe/ferre/ferre.pdf>`__ format (as used
  by the :ads_citealp:`allende:2018` grids).

* :command:`goettingen_to_specint` --- extract a single flux spectrum
  from a FITS data file (as described in :ads_citealp:`husser:2013`)

Modifying Spectra
-----------------

Individal spectra produced by one of the tools above can be subsetted
and/or rebinned using the :command:`specint_to_specint` tool.

Creating Grids
--------------

With a set of spectrum files extracted, a spectroscopic grid can be
created using the :command:`make_specgrid` tool. First, prepare a
manifest file --- a simple text file that lists all the spectrum files
that should be part of the grid. Then, run the command

.. shell:

   $MSG_DIR/bin/make_specgrid <manifest_file> <specgrid_file> [<allow_dupes>]

Here, :file:`<manifest_file>` is the name of the input manifest file,
:file:`<specgrid_file>` is the name of the output grid file, and
:file:`<allow_dupes>` is an optional logical flag (`.TRUE.` or
`.FALSE.`) that determines whether dupilcate grid points are allowed
in the manifest.

Once a spectroscopic grid is created, corresponding photometric grids
(with the same topology) can be created using the command

.. shell:

   $MSG_DIR/bin/specgrid_to_photgrid <specgrid_file> <passband_file> <photgrid_file>

Here, :file:`<specgrid_file>` is the name of the input spectroscopic
grid file, :file:`<passband_file>` is the name of the passband file to convolve with, and :file:`<specgrid_file>` is the name of the output photometric
grid file.

Note that it's not always necessary to create a photometric grid, as
MSG can convolve with passbands on the fly (see, e.g., the
:ref:`python-walkthrough` chapter).
      
.. |br| raw:: html

   <br>

