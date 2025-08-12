.. rst:group-schema:: comp_range

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
     - literal ``'comp_range_t'``.
   * - ``REVISION``
     - attribute
     - integer
     - literal ``1``.
   * - ``n_ranges``
     - dataset
     - integer
     - number of sub-ranges.
   * - ``ranges[i]``
     - group
     - :g-schema:`lin_range` | :g-schema:`log_range` | :g-schema:`tab_range` | :g-schema:`comp_range`
     - sub-ranges (``i = 1, ..., n_ranges``).
