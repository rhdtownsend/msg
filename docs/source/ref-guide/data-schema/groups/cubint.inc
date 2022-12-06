.. rst:group-schema:: cubint

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
     - literal :code:`'cubint_t'`.
   * - :code:`REVISION`
     - attribute
     - integer
     - literal :code:`1`.
   * - :code:`n`
     - attribute
     - integer
     - number of points.
   * - :code:`x`
     - dataset
     - real(:code:`n`)
     - abscissa values.
   * - :code:`f`
     - dataset
     - real(:code:`n`)
     - ordinate values.
   * - :code:`df_dx`
     - dataset
     - real(:code:`n`)
     - derivative values.
