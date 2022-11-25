.. _data-schema-specint:

specint_t
=========

limb_specint_t
--------------

.. _data-schema-limb-specint:

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
     - precision of data (`.TRUE.` for 64-bit, `.FALSE.` for 32-bit).
   * - :code:`c`
     - dataset
     - real(:,:)
     - intensity coefficients (erg/cm^2/s/Å/sr).
   * - :code:`range`
     - group
     - range_t
     - wavelength grid (Å).
   * - :code:`limb`
     - group
     - :ref:`data-schema-limb`
     - limb-darkening law.
