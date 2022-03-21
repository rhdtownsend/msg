.. _spectral-grids:

**************
Spectral Grids
**************

Due to their large size and gradually evolving content (as
improvements are made), spectral grids are not shipped as part of the
:git:`rhdtownsend/msg` git repository; they must be downloaded
separately (the sole exception is the demo grid,
:file:`$MSG_DIR/data/grids/sg-demo.h5`). This chapter describes the
various grids currently available, and discusses how custom grids can be
created.

CAP18 Grids
===========

The CAP18 grids are based on the data published in
:ads_citet:`allende:2018` (the letters 'CAP' are the initials of the
first author). These data comprise flux spectra (not intensity
spectra) spanning a wide range of effective temperatures, gravities
and metallicities. For all but the 'large' grid, alpha enhancement is
set parametrically from the metallicity, as described in XXXX.

.. list-table::
   :header-rows: 1	
   :widths: 20 12 12 12 44
	 
   * - File
     - :math:`\Teff/{\rm K}`
     - :math:`\log g`
     - :math:`[{\rm Fe}/{\rm H}]`
     - Notes
   * - :grids:`sg-CAP18-coarse.h5 <CAP18/sg-CAP18-coarse.h5>`
     - 3,500 -- 30,000
     - 0.0 -- 5.0
     - -5.0 -- 0.5
     - Based on nsc{1..5} (coarse) grids; :math:`R=10,000`.
   * - :grids:`sg-CAP18-high.h5 <CAP18/sg-CAP18-high.h5>`
     - 3,500 -- 30,000
     - 0.0 -- 5.0
     - -5.0 -- 0.5
     - Based on hnsc{1..5} (high-resolution coarse) grids; :math:`R=100,000`.
   * - :grids:`sg-CAP18-ultra.h5 <CAP18/sg-CAP18-ultra.h5>`
     - 3,500 -- 30,000
     - 0.0 -- 5.0
     - -5.0 -- 0.5
     - Based on uhnsc{1..5} (ultra high-resolution coarse) grids; :math:`R=300,000`.

Gottingen Grids
===============

The Goettingen grids are based on the data published in
:ads_citet:`husser:2013`. These data comprise flux spectra (not
intensity spectra) spanning a wide range of effective temperatures,
gravities, metallicities and alpha enhancements.

.. list-table::
   :header-rows: 1	
   :widths: 20 12 12 12 44
	 
   * - File
     - :math:`\Teff/{\rm K}`
     - :math:`\log g`
     - :math:`[{\rm Fe}/{\rm H}]`
     - Notes
   * - :grids:`sg-CAP18-coarse.h5 <CAP18/sg-CAP18-coarse.h5>`
     - 3,500 -- 30,000
     - 0.0 -- 5.0
     - -5.0 -- 0.5
     - Based on nsc{1..5} (coarse) grids; :math:`R=10,000`.
   * - :grids:`sg-CAP18-high.h5 <CAP18/sg-CAP18-high.h5>`
     - 3,500 -- 30,000
     - 0.0 -- 5.0
     - -5.0 -- 0.5
     - Based on hnsc{1..5} (high-resolution coarse) grids; :math:`R=100,000`.
   * - :grids:`sg-CAP18-ultra.h5 <CAP18/sg-CAP18-ultra.h5>`
     - 3,500 -- 30,000
     - 0.0 -- 5.0
     - -5.0 -- 0.5
     - Based on uhnsc{1..5} (ultra high-resolution coarse) grids; :math:`R=300,000`.


