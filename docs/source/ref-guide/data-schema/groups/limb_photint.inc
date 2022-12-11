.. rst:group-schema:: limb_photint

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
     - literal :code:`'limb_photint_t'`.
   * - :code:`REVISION`
     - attribute
     - integer
     - literal :code:`1`.
   * - :code:`precise`
     - attribute
     - logical
     - precision of data (`.TRUE.` for 64-bit, `.FALSE.` for 32-bit).
   * - :code:`c`
     - dataset
     - real(:)
     - intensity coefficients (/sr).
   * - :code:`limb`
     - group
     - :g-schema:`limb`
     - limb-darkening law.
