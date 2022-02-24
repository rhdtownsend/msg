.. _specgral-grids:

**************
Spectral Grids
**************

Due to their large size and gradually evolving content (as
improvements are made), the spectral grids used by MSG are not shipped
as part of the :git:`rhdtownsend/msg` git repository; they must be
downloaded separately. This chapter describes the various grids
available for download, and discusses how custom grids can be created.

Demo Grid
=========

The demo grid is based on the solar-metallicity temperature-gravity
grid of stellar atmospheres published by
:ads_citet:`castelli:2003`. Intensity spectra are evaluated using
`SYNSPEC <http://tlusty.oca.eu/Synspec49/synspec.html>`__. 

.. list-table::
   :header-rows: 1	
   :widths: 20 18 18 44
	 
   * - File
     - :math:`\Teff/{\rm K}`
     - :math:`\log g`
     - Notes
   * - :grids:`sg-demo.h5 <demo/sg-demo.h5>`
     - 3,500 -- 49,000
     - 0.0 -- 5.0
     - Wavelength range :math:`2500\,\angstrom - 12500\,\angstrom`
       with :math:`R=1000`. 4-coefficient :ads_citep:`claret:2000`
       limb-darkening law.


CAP18 Grids
===========

The CAP18 grids are based on the data published in
:ads_citet:`allende:2018` (the letters 'CAP' are the initials of the
first author). These data comprise flux spectra (not intensity
spectra) spanning a wide range of effective temperatures, gravities
and metallicities.

.. list-table::
   :header-rows: 1	
   :widths: 20 12 12 12 44
	 
   * - File
     - :math:`\Teff/{\rm K}`
     - :math:`\log g`
     - :math:`[{\rm Fe}/{\rm H}]`
     - Notes
   * - :grids:`sg-CAP18-coarse-base.h5 <CAP18/sg-CAP18-coarse-base.h5>`
     - 3,500 -- 30,000
     - 0.0 -- 5.0
     - -5.0 -- 0.5
     - Based on nsc (coarse) grid.
   * - :grids:`sg-CAP18-coarse-3000.h5 <CAP18/sg-CAP18-coarse-3000.h5>`
     - 3,500 -- 30,000
     - 0.0 -- 5.0
     - -5.0 -- 0.5
     - Based on nsc (coarse) grid, downsampled to :math:`R=3000`.

   


