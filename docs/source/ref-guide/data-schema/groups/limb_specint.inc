.. rst:group-schema:: limb_specint

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
     - literal :code:`'limb_specint_t'`.
   * - :code:`REVISION`
     - attribute
     - integer
     - literal :code:`1`.
   * - :code:`lam_min`
     - attribute
     - real
     - minimum wavelength (Å).
   * - :code:`lam_max`
     - attribute
     - real
     - maximum wavelength (Å).
   * - :code:`precise`
     - attribute
     - logical
     - storage precision of :code:`c` (true for `H5T_IEEE_F64LE`, false for `H5T_IEEE_F32LE`).
   * - :code:`c`
     - dataset
     - real(:,:)
     - intensity coefficients (erg/cm^2/s/Å/sr).
   * - :code:`range`
     - group
     - :g-schema:`lin_range` | :g-schema:`log_range` | :g-schema:`tab_range` | :g-schema:`comp_range`
     - wavelength grid (Å).
   * - :code:`limb`
     - group
     - :g-schema:`limb`
     - limb-darkening law.
