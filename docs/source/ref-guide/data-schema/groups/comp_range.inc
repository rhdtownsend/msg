.. rst:group-schema:: comp_range

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
     - literal :code:`'comp_range_t'`.
   * - :code:`REVISION`
     - attribute
     - integer
     - literal :code:`1`.
   * - :code:`n_ranges`
     - dataset
     - integer
     - number of sub-ranges.
   * - :code:`ranges[i]`
     - group
     - :g-schema:`lin_range` | :g-schema:`log_range` | :g-schema:`tab_range` | :g-schema:`comp_range`
     - sub-ranges (:code:`i = 1, ..., n_ranges`).
