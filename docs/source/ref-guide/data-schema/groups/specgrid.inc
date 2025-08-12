.. rst:group-schema:: specgrid

.. list-table::
   :widths: 20 15 20 45
   :header-rows: 1

   * - Item
     - Object Type
     - Data Type
     - Definition
   * - ``TYPE``
     - attribute
     - character
     - literal ``'specgrid_t'``.
   * - ``REVISION``
     - attribute
     - integer
     - literal ``1``.
   * - ``specsource/n``
     - attribute
     - integer
     - number of specints.
   * - ``specsource/lam_min``
     - attribute
     - real
     - minimum wavelength (Å).
   * - ``specsource/lam_max``
     - attribute
     - real
     - maximum wavelength (Å).
   * - ``specsource/specints[i]``
     - group
     - :g-schema:`limb_specint`
     - grid specints (``i = 1, ..., n``).
   * - ``vgrid``
     - group
     - :g-schema:`vgrid`
     - virtual grid.
