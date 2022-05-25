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
atmospheres published in :ads_citep:`lanz:2003`. They contain
intensity spectra calculated by the MSG Team using SYNSPEC, and are as
follows:

.. list-table::
   :header-rows: 1	
   :widths: 30 10 10 50
	 
   * - File
     - Resolution
     - :math:`\lambda` Range
     - Atmospheric Parameters
   * - :grids:`sg-OSTAR2002-low.h5 <OSTAR2002/sg-OSTAR2002-low.h5>` (50MB)
     - :math:`R=1\,000`
     - :math:`[8\,80, 50\,000]\,\angstrom`
     - ``Teff``, ``log(g)``, ``Z/Zo``
   * - :grids:`sg-OSTAR2002-medium.h5 <OSTAR2002/sg-OSTAR2002-medium.h5>` (447MB)
     - :math:`R=10\,000`
     - :math:`[8\,80, 50\,000]\,\angstrom`
     - ``Teff``, ``log(g)``, ``Z/Zo``
   * - :grids:`sg-OSTAR2002-high.h5 <OSTAR2002/sg-OSTAR2002-high.h5>` (4.2GB)
     - :math:`R=100\,000`
     - :math:`[8\,80, 50\,000]\,\angstrom`
     - ``Teff``, ``log(g)``, ``Z/Zo``

The definitions and ranges of the atmospheric parameters are as follows:

* effective temperature ``Teff`` :math:`= \Teff/\kelvin \in [27\,500, 55\,000]`
* surface gravity ``log(g)`` :math:`= \log_{10} (g/\cm\,\second^{-2}) \in [3.0, 4.75]`
* metallicity ``Z/Zo`` :math:`= Z/Z_{\odot} \in [0.02, 2]`


.. _grid-files-bstar2006:

BSTAR2006 Grids
===============

The BSTAR2006 grids are based on the line-blanketed B-star model
atmospheres published in :ads_citep:`lanz:2007`. They contain
intensity spectra calculated by the MSG Team using SYNSPEC, and are as
follows:

.. list-table::
   :header-rows: 1	
   :widths: 30 10 10 50
	 
   * - File
     - Resolution
     - :math:`\lambda` Range
     - Atmospheric Parameters
   * - :grids:`sg-BSTAR2006-low.h5 <BSTAR2006/sg-BSTAR2006-low.h5>` (77MB)
     - :math:`R=1\,000`
     - :math:`[8\,80, 50\,000]\,\angstrom`
     - ``Teff``, ``log(g)``, ``Z/Zo``, ``xi``
   * - :grids:`sg-BSTAR2006-medium.h5 <BSTAR2006/sg-BSTAR2006-medium.h5>` (693MB)
     - :math:`R=10\,000`
     - :math:`[8\,80, 50\,000]\,\angstrom`
     - ``Teff``, ``log(g)``, ``Z/Zo``, ``xi``
   * - :grids:`sg-BSTAR2006-high.h5 <BSTAR2006/sg-BSTAR2006-high.h5>` (6.5GB)
     - :math:`R=100\,000`
     - :math:`[8\,80, 50\,000]\,\angstrom`
     - ``Teff``, ``log(g)``, ``Z/Zo``, ``xi``

The definitions and ranges of the atmospheric parameters are as
follows:

* effective temperature ``Teff`` :math:`= \Teff/\kelvin \in [15\,000, 30\,000]`
* surface gravity ``log(g)`` :math:`= \log_{10} (g/\cm\,\second^{-2}) \in [1.753.00, 4.75]`
* metallicity ``Z/Zo`` :math:`= Z/Z_{\odot} \in [0, 2]`


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
     - ``Teff``, ``log(g)``, ``[Fe/H]``, ``[alpha/Fe]``, ``log(xi)``
   * - :grids:`sg-CAP18-coarse.h5 <CAP18/sg-CAP18-coarse.h5>` (340MB)
     - :math:`\mathcal{R}=10\,000`
     - :math:`[1\,300, 65\,000]\,\angstrom`
     - ``Teff``, ``log(g)``, ``[Fe/H]``
   * - :grids:`sg-CAP18-high.h5 <CAP18/sg-CAP18-high.h5>` (2.9GB)
     - :math:`\mathcal{R}=100\,000`
     - :math:`[1\,300, 65\,000]\,\angstrom`
     - ``Teff``, ``log(g)``, ``[Fe/H]``
   * - :grids:`sg-CAP18-ultra.h5 <CAP18/sg-CAP18-ultra.h5>` (5.2GB)
     - :math:`\mathcal{R}=300\,000`
     - :math:`[1\,300, 65\,000]\,\angstrom`
     - ``Teff``, ``log(g)``, ``[Fe/H]``

The definitions and ranges of the atmospheric parameters are as follows:

* effective temperature ``Teff`` :math:`= \Teff/\kelvin \in [27\,500, 55\,000]`
* surface gravity ``log(g)`` :math:`= \log_{10} (g/\cm\,\second^{-2}) \in [3.0, 4.5]`
* metallicity ``[Fe/H]`` :math:`= \log_{10}[ (\mathrm{Fe}/\mathrm{H}) / (\mathrm{Fe}/\mathrm{H})_{\odot} ] \in [-5.0, 0.5]`
* alpha enhancement ``[alpha/Fe]`` :math:`= \log_{10}[ (\alpha/\mathrm{Fe}) / (\alpha/\mathrm{Fe})_{\odot} ] \in [-5.0, 0.5]`
* microturbulent velocity ``log(xi)`` :math:`= \log_{10} (\xi/\cm\,\second^{-1}) \in [-0.301,0.903]`

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
     - ``Teff``, ``log(g)``, ``[Fe/H]``, ``[alpha/Fe]``
   * - :grids:`sg-Goettingen-MedRes-A.h5 <Goettingen/sg-Goettingen-MedRes-A.h5>` (5.9GB)
     - :math:`\Delta \lambda = 1\,\angstrom` |br| (:math:`10\times` oversampled)
     - :math:`[3\,000, 10\,000]\,\angstrom`
     - ``Teff``, ``log(g)``, ``[Fe/H]``, ``[alpha/Fe]``
   * - :grids:`sg-Goettingen-MedRes-R.h5 <Goettingen/sg-Goettingen-MedRes-R.h5>` (17GB)
     - :math:`R=10,000` |br| (:math:`10\times` oversampled)
     - :math:`[3\,000, 25\,000]\,\angstrom`
     - ``Teff``, ``log(g)``, ``[Fe/H]``, ``[alpha/Fe]``

The definitions and ranges of the atmospheric parameters are as follows:

* effective temperature ``Teff`` :math:`= \Teff/\kelvin \in [2\,300, 12\,000]`
* surface gravity ``log(g)`` :math:`= \log_{10}(g/\cm\,\second^{-2}) \in [0.0, 6.0]`
* metallicity ``[Fe/H]`` :math:`= \log_{10}[ (\mathrm{Fe}/\mathrm{H}) / (\mathrm{Fe}/\mathrm{H})_{\odot} ] \in [-4.0, 1.0]`
* alpha enhancement ``[alpha/H]`` :math:`= \log_{10}[ (\alpha/\mathrm{Fe}) / (\alpha/\mathrm{Fe})_{\odot} ] \in [-0.2,1.2]`


.. |br| raw:: html

   <br>

