.. rst:group-schema:: cubint

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
     - literal ``'cubint_t'``.
   * - ``REVISION``
     - attribute
     - integer
     - literal ``1``.
   * - ``n``
     - attribute
     - integer
     - number of points.
   * - ``x``
     - dataset
     - real(``n``)
     - abscissa values.
   * - ``f``
     - dataset
     - real(``n``)
     - ordinate values.
   * - ``df_dx``
     - dataset
     - real(``n``)
     - derivative values.
