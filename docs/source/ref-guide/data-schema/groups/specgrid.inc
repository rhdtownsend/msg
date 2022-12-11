.. rst:group-schema:: specgrid

.. list-table::
   :widths: 15 10 10 65
   :header-rows: 1

   * - Item
     - Object Type
     - Data Type
     - Definition
   * - :code:`TYPE`
     - attribute
     - character
     - literal :code:`'specgrid_t'`.
   * - :code:`REVISION`
     - attribute
     - integer
     - literal :code:`1`.
   * - :code:`specsource/n`
     - attribute
     - integer
     - number of specints.
   * - :code:`specsource/lam_min`
     - attribute
     - real
     - minimum wavelength (Å).
   * - :code:`specsource/lam_max`
     - attribute
     - real
     - maximum wavelength (Å).
   * - :code:`specsource/specints[i]`
     - group
     - :g-schema:`limb_specint`
     - grid specints (:code:`i = 1, ..., n`).
   * - :code:`vgrid`
     - group
     - :g-schema:`vgrid`
     - virtual grid.
