.. _data-schema-photgrid:

photgrid_t
==========

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
     - literal :code:`'photgrid_t'`.
   * - :code:`REVISION`
     - attribute
     - integer
     - literal :code:`1`.
   * - :code:`photsource/n`
     - attribute
     - integer
     - number of photints.
   * - :code:`photsource/photints[i]`
     - group
     - :ref:`photint_t`
     - grid photints (:code:`i = 1, ..., n`).
   * - :code:`vgrid`
     - group
     - :ref:`data-schema-vgrid`
     - virtual grid.
