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


.. _grid-files-ostar2002:

OSTAR2002 Grids
===============

The OSTAR2002 grids are based on the line-blanketed O-star model
atmospheres published in :ads_citet:`lanz:2003`. Spectra are
calculated from these atmospheres using SYNSPEC, and their angle
dependence parameterized with the `CLARET` limb-darkening law.

.. list-table::
   :header-rows: 1	
   :widths: 30 10 10 50
	 
   * - File
     - Resolution
     - :math:`\lambda` Range
     - Atmospheric Parameters
   * - :grids:`sg-OSTAR2002-low.h5 <OSTAR2002/sg-OSTAR2002-low.h5>` (50MB)
     - :math:`\mathcal{R}=1000`
     - :math:`[880\,\angstrom, 5.0\,\um]`
     - ``Teff``, ``log(g)``, ``Z/Zo``
   * - :grids:`sg-OSTAR2002-medium.h5 <OSTAR2002/sg-OSTAR2002-medium.h5>` (447MB)
     - :math:`\mathcal{R}=10000`
     - :math:`[880\,\angstrom, 5.0\,\um]`
     - ``Teff``, ``log(g)``, ``Z/Zo``
   * - :grids:`sg-OSTAR2002-high.h5 <OSTAR2002/sg-OSTAR2002-high.h5>` (4.2GB)
     - :math:`\mathcal{R}=100000`
     - :math:`[880\,\angstrom, 5.0\,\um]`
     - ``Teff``, ``log(g)``, ``Z/Zo``

The definitions and ranges of the atmospheric parameters are as
follows:

* effective temperature ``Teff`` :math:`= \Teff/\kelvin \in [27500, 55000]`
* surface gravity ``log(g)`` :math:`= \log_{10} (g/\cm\,\second^{-2}) \in [3.0, 4.75]`
* metallicity ``Z/Zo`` :math:`= Z/Z_{\odot} \in [0.02, 2]`


.. _grid-files-bstar2006:

BSTAR2006 Grids
===============

The BSTAR2006 grids are based on the line-blanketed B-star model
atmospheres published in :ads_citet:`lanz:2007`. Spectra are
calculated from these atmospheres using SYNSPEC, and their angle
dependence parameterized with the `CLARET` limb-darkening law.

.. list-table::
   :header-rows: 1	
   :widths: 30 10 10 50
	 
   * - File
     - Resolution
     - :math:`\lambda` Range
     - Atmospheric Parameters
   * - :grids:`sg-BSTAR2006-low.h5 <BSTAR2006/sg-BSTAR2006-low.h5>` (77MB)
     - :math:`\mathcal{R}=1000`
     - :math:`[880\,\angstrom, 5\,\um]`
     - ``Teff``, ``log(g)``, ``Z/Zo``
   * - :grids:`sg-BSTAR2006-medium.h5 <BSTAR2006/sg-BSTAR2006-medium.h5>` (693MB)
     - :math:`\mathcal{R}=10000`
     - :math:`[880\,\angstrom, 5\,\um]`
     - ``Teff``, ``log(g)``, ``Z/Zo``
   * - :grids:`sg-BSTAR2006-high.h5 <BSTAR2006/sg-BSTAR2006-high.h5>` (6.5GB)
     - :math:`\mathcal{R}=100000`
     - :math:`[880\,\angstrom, 5\,\um]`
     - ``Teff``, ``log(g)``, ``Z/Zo``

The definitions and ranges of the atmospheric parameters are as
follows:

* effective temperature ``Teff`` :math:`= \Teff/\kelvin \in [15000, 30000]`
* surface gravity ``log(g)`` :math:`= \log_{10} (g/\cm\,\second^{-2}) \in [1.753.00, 4.75]`
* metallicity ``Z/Zo`` :math:`= Z/Z_{\odot} \in [0, 2]`


.. _grid-files-CAP18:

CAP18 Grids
===========

The CAP18 grids are based on the data published in
:ads_citet:`allende:2018` (the letters 'CAP' are the initials of the
first author). The angle dependence of spectra is parameterized with the `CONST`
limb-darkening law.

.. list-table::
   :header-rows: 1	
   :widths: 30 10 10 50
	 
   * - File
     - Resolution
     - :math:`\lambda` Range
     - Atmospheric Parameters
   * - :grids:`sg-CAP18-large.h5 <CAP18/sg-CAP18-large.h5>` (73GB)
     - :math:`\mathcal{R}=10000`
     - :math:`[1300\,\angstrom, 6.5\,\um]`
     - ``Teff``, ``log(g)``, ``[Fe/H]``, ``[alpha/Fe]``, ``log(xi)``
   * - :grids:`sg-CAP18-coarse.h5 <CAP18/sg-CAP18-coarse.h5>` (339MB)
     - :math:`\mathcal{R}=10000`
     - :math:`[1300\,\angstrom, 6.5\,\um]`
     - ``Teff``, ``log(g)``, ``[Fe/H]``
   * - :grids:`sg-CAP18-high.h5 <CAP18/sg-CAP18-high.h5>` (2.9GB)
     - :math:`\mathcal{R}=100000`
     - :math:`[1300\,\angstrom, 6.5\,\um]`
     - ``Teff``, ``log(g)``, ``[Fe/H]``
   * - :grids:`sg-CAP18-ultra.h5 <CAP18/sg-CAP18-ultra.h5>` (5.2GB)
     - :math:`\mathcal{R}=300000`
     - :math:`[1300\,\angstrom, 6.5\,\um]`
     - ``Teff``, ``log(g)``, ``[Fe/H]``

The definitions and ranges of the atmospheric parameters are as follows:

* effective temperature ``Teff`` :math:`= \Teff/\kelvin \in [3500, 30000]`
* surface gravity ``log(g)`` :math:`= \log_{10} (g/\cm\,\second^{-2}) \in [0.0, 5.0]`
* metallicity ``[Fe/H]`` :math:`= \log_{10}[ (\mathrm{Fe}/\mathrm{H}) / (\mathrm{Fe}/\mathrm{H})_{\odot} ] \in [-5.0, 0.5]`
* alpha enhancement ``[alpha/Fe]`` :math:`= \log_{10}[ (\alpha/\mathrm{Fe}) / (\alpha/\mathrm{Fe})_{\odot} ] \in [-1.0, 1.0]`
* microturbulent velocity ``log(xi)`` :math:`= \log_{10} (\xi/\cm\,\second^{-1}) \in [-0.301,0.903]`

.. _grid-files-Göttingen:

Göttingen Grids
===============

The Göettingen grids are based on the data described in
:ads_citet:`husser:2013` and available for download from
`phoenix.astro.physik.uni-goettingen.de
<https://phoenix.astro.physik.uni-goettingen.de/>`__. The angle
dependence of spectra is parameterized with the `CONST` limb-darkening
law.

.. list-table::
   :header-rows: 1	
   :widths: 30 10 10 50
	 
   * - File
     - Resolution
     - :math:`\lambda` Range
     - Atmospheric Parameters
   * - :grids:`sg-Goettingen-HiRes.h5 <Goettingen/sg-Goettingen-HiRes.h5>` (116GB)
     - variable
     - :math:`[500\,\angstrom, 5.5\um]`
     - ``Teff``, ``log(g)``, ``[Fe/H]``, ``[alpha/Fe]``
   * - :grids:`sg-Goettingen-MedRes-A.h5 <Goettingen/sg-Goettingen-MedRes-A.h5>` (6.0GB)
     - :math:`\Delta \lambda = 1\,\angstrom` |br| (:math:`10\times` oversampled)
     - :math:`[3000\,\angstrom, 1.0\um]`
     - ``Teff``, ``log(g)``, ``[Fe/H]``, ``[alpha/Fe]``
   * - :grids:`sg-Goettingen-MedRes-R.h5 <Goettingen/sg-Goettingen-MedRes-R.h5>` (18GB)
     - :math:`\mathcal{R}=10,000` |br| (:math:`10\times` oversampled)
     - :math:`[3000\,\angstrom, 2.5\,\um]`
     - ``Teff``, ``log(g)``, ``[Fe/H]``, ``[alpha/Fe]``

The definitions and ranges of the atmospheric parameters are as follows:

* effective temperature ``Teff`` :math:`= \Teff/\kelvin \in [2\,300, 12\,000]`
* surface gravity ``log(g)`` :math:`= \log_{10}(g/\cm\,\second^{-2}) \in [0.0, 6.0]`
* metallicity ``[Fe/H]`` :math:`= \log_{10}[ (\mathrm{Fe}/\mathrm{H}) / (\mathrm{Fe}/\mathrm{H})_{\odot} ] \in [-4.0, 1.0]`
* alpha enhancement ``[alpha/H]`` :math:`= \log_{10}[ (\alpha/\mathrm{Fe}) / (\alpha/\mathrm{Fe})_{\odot} ] \in [-0.2,1.2]`


.. |br| raw:: html

   <br>

