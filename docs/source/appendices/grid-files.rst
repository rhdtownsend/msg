.. _grid-files:

**********
Grid Files
**********

Due to their large size and gradually evolving content (as
improvements are made), HDF5 `specgrid` files are not shipped as part of the
:git:`rhdtownsend/msg` git repository; they must be downloaded
separately (the sole exception is the demo grid,
:file:`$MSG_DIR/data/grids/sg-demo.h5`). This chapter describes the
various grids currently available.


.. _grid-files-tlusty:

OSTAR2002 Grids
===============

The OSTAR2002 are based on the model atmospheres published in
:ads_citep:`lanz:2003`. They contain intensity spectra calculated from
the atmospheres using SYNSPEC, and are as follows:

.. list-table::
   :header-rows: 1	
   :widths: 30 10 10 50
	 
   * - `specgrid` File
     - Resolution
     - :math:`\lambda` Range
     - Atmospheric Parameters
   * - :grids:`sg-OSTAR2002-1000.h5 <OSTAR2002/sg-OSTAR2002-1000.h5>` (XXGB)
     - :math:`R=1\,000`
     - :math:`[8\,80, 50\,000]\,\angstrom`
     - :math:`\Teff`, :math:`\log g`, :math:`[\FeH]`
   * - :grids:`sg-OSTAR2002-10000.h5 <OSTAR2002/sg-OSTAR2002-10000.h5>` (XXGB)
     - :math:`R=10\,000`
     - :math:`[8\,80, 50\,000]\,\angstrom`
     - :math:`\Teff`, :math:`\log g`, :math:`[\FeH]`
   * - :grids:`sg-OSTAR2002-100000.h5 <OSTAR2002/sg-OSTAR2002-100000.h5>` (XXGB)
     - :math:`R=100\,000`
     - :math:`[8\,80, 50\,000]\,\angstrom`
     - :math:`\Teff`, :math:`\log g`, :math:`[\FeH]`

The ranges of the atmospheric parameters are as follows:

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
	 
   * - `specgrid` File
     - Resolution
     - :math:`\lambda` Range
     - Atmospheric Parameters
   * - :grids:`sg-CAP18-large.h5 <CAP18/sg-CAP18-large.h5>` (72GB)
     - :math:`R=10\,000`
     - :math:`[1\,300, 65\,000]\,\angstrom`
     - :math:`\Teff`, :math:`\log g`, :math:`[\FeH]`, :math:`[\aFe]`, :math:`\log \xi`
   * - :grids:`sg-CAP18-coarse.h5 <CAP18/sg-CAP18-coarse.h5>` (340MB)
     - :math:`\mathcal{R}=10\,000`
     - :math:`[1\,300, 65\,000]\,\angstrom`
     - :math:`\Teff`, :math:`\log g`, :math:`[\FeH]`
   * - :grids:`sg-CAP18-high.h5 <CAP18/sg-CAP18-high.h5>` (2.9GB)
     - :math:`\mathcal{R}=100\,000`
     - :math:`[1\,300, 65\,000]\,\angstrom`
     - :math:`\Teff`, :math:`\log g`, :math:`[\FeH]`
   * - :grids:`sg-CAP18-ultra.h5 <CAP18/sg-CAP18-ultra.h5>` (5.2GB)
     - :math:`\mathcal{R}=300\,000`
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
	 
   * - `specgrid` File
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

.. |br| raw:: html

   <br>

