.. _data-schema-photint-group:

Photint Group
=============

Limb-darkened
-------------

.. _data-schema-limb-photint:

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
     - :ref:`data-schema-limb-group`
     - limb-darkening law.
