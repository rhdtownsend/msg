.. _data-schema-vgrid:

vgrid_t
=======

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
     - literal :code:`'vgrid_t'`.
   * - :code:`REVISION`
     - attribute
     - integer
     - literal :code:`1`.
   * - :code:`shape`
     - attribute
     - integer(:code:`rank`)
     - shape of grid.
   * - :code:`rank`
     - attribute
     - integer
     - rank of grid.
   * - :code:`axes(i)`
     - group
     - :ref:`data-schema-axis`
     - grid axes (:code:`i = 1, ..., rank`).
