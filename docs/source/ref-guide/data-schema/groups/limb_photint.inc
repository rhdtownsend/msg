.. rst:group-schema:: limb_photint

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
     - literal ``'limb_photint_t'``.
   * - ``REVISION``
     - attribute
     - integer
     - literal ``1``.
   * - ``precise``
     - attribute
     - logical
     - precision of data (`.TRUE.` for 64-bit, `.FALSE.` for 32-bit).
   * - ``c``
     - dataset
     - real(:)
     - intensity coefficients (/sr).
   * - ``limb``
     - group
     - :g-schema:`limb`
     - limb-darkening law.
