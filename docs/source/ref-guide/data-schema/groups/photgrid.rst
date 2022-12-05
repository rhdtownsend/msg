.. _data-schema-groups-photgrid:

:grouptype:`photgrid`
=====================

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
     - :groupref:`photint`
     - grid photints (:code:`i = 1, ..., n`).
   * - :code:`vgrid`
     - group
     - :groupref:`vgrid`
     - virtual grid.
