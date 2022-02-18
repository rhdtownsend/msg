.. _data-grids:

**********
Data Grids
**********

Due to their large size, the data grids used by MSG are not shipped as
part of the :git:`rhdtownsend/msg` git repository; they must be
downloaded separately. This chapter describes the various grids
available for download, and discusses how custom grids can be created.

CAP18 Grids
===========

The CAP18 grids are based on the data published in
:ads_citet:`allende:2018` (the letters 'CAP' are the initials of the
first author). These data comprise flux spectra (not intensity
spectra) spanning a wide range of effective temperatures, gravities
and metallicities. The table below provides links to corresponding MSG
data.

.. list-table::
   :header-rows: 1	
   :widths: 20 12 12 12 44
	 

   * - File
     - :math:`\Teff/{\rm K}`
     - :math:`\log g`
     - :math:`[{\rm Fe}/{\rm H}]`
     - Notes
   * - :grid:`sg-cap18-coarse-base.h5`
     - 3,500 -- 30,000
     - 0.0 -- 5.0
     - -5.0 -- 0.5
     - Based on nsc (coarse) grid, subsetted to the wavelength range
       :math:`3,000\,\angstrom - 25,000\,\angstrom`
   * - :grid:`sg-cap18-coarse-3000.h5`
     - 3,500 -- 30,000
     - 0.0 -- 5.0
     - -5.0 -- 0.5
     - Based on nsc (coarse) grid, subsetted to the wavelength range
       :math:`3,000\,\angstrom - 25,000\,\angstrom` and
       downsampled to a resolution of 3,000
     


