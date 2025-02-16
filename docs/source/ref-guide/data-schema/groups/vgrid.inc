.. rst:group-schema:: vgrid

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
     - literal :code:`'vgrid_t'`.
   * - :code:`REVISION`
     - attribute
     - integer
     - literal :code:`2`.
   * - :code:`shape`
     - attribute
     - integer(:code:`rank`)
     - shape of grid.
   * - :code:`rank`
     - attribute
     - integer
     - rank of grid.
   * - :code:`axes[i]`
     - group
     - :g-schema:`axis`
     - grid axes (:code:`i = 1, ..., rank`).
