.. rst:group-schema:: limb_specint

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
     - literal ``'limb_specint_t'``.
   * - ``REVISION``
     - attribute
     - integer
     - literal ``1``.
   * - ``lam_min``
     - attribute
     - real
     - minimum wavelength (Å).
   * - ``lam_max``
     - attribute
     - real
     - maximum wavelength (Å).
   * - ``precise``
     - attribute
     - logical
     - storage precision of ``c` (true for `H5T_IEEE_F64LE`, false for `H5T_IEEE_F32LE``).
   * - ``c``
     - dataset
     - real(:,:)
     - intensity coefficients (erg/cm^2/s/Å/sr).
   * - ``range``
     - group
     - :g-schema:`lin_range` | :g-schema:`log_range` | :g-schema:`tab_range` | :g-schema:`comp_range`
     - wavelength grid (Å).
   * - ``limb``
     - group
     - :g-schema:`limb`
     - limb-darkening law.
