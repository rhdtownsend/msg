.. _data-schema-specint-group:

Specint Group
=============

Limb-Darkened
-------------

.. list-table::
   :widths: 15 10 10 65
   :header-rows: 1

   * - Item
     - Objtype
     - Datatype
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
     - :ref:`data-schema-range-group`
     - wavelength grid (Å).
   * - :code:`limb`
     - group
     - :ref:`data-schema-limb-group`
     - limb-darkening law.
