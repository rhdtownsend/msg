.. rst:group-schema:: vgrid

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
     - literal ``'vgrid_t'``.
   * - ``REVISION``
     - attribute
     - integer
     - literal ``3``.
   * - ``shape``
     - attribute
     - integer(``rank``)
     - shape of grid.
   * - ``rank``
     - attribute
     - integer
     - rank of grid.
   * - ``v_lin_seq``
     - dataset
     - integer(:)
     - vertex sequence-to-linear mapping.
   * - ``axes[i]``
     - group
     - :g-schema:`axis`
     - grid axes (``i = 1, ..., rank``).
