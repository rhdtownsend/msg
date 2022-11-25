.. _data-schema-range:

range_t
=======

lin_range_t
-----------

.. _data-schema-lin-range:

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
     - literal :code:`'lin_range_t'`.
   * - :code:`REVISION`
     - attribute
     - integer
     - literal :code:`1`.
   * - :code:`x_0`
     - attribute
     - real
     - abscissa start value.
   * - :code:`dx`
     - attribute
     - real
     - abscissa spacing.
   * - :code:`n`
     - attribute
     - integer
     - number of points.


log_range_t
-----------

.. _data-schema-log-range:

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
     - literal :code:`'log_range_t'`.
   * - :code:`REVISION`
     - attribute
     - integer
     - literal :code:`1`.
   * - :code:`logx_0`
     - attribute
     - real
     - logarithm of abscissa start value.
   * - :code:`dlogx`
     - attribute
     - real
     - abscissa logarithmic spacing.
   * - :code:`n`
     - attribute
     - integer
     - number of points.
     

tab_range_t
-----------

.. _data-schema-tab-range:

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
     - literal :code:`'tab_range_t'`.
   * - :code:`REVISION`
     - attribute
     - integer
     - literal :code:`1`.
   * - :code:`x`
     - dataset
     - real(:)
     - abscissa values.


comp_range_t
------------

.. _data-schema-comp-range:

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
     - :ref:`data-schema-range`
     - sub-ranges (:code:`i = 1, ..., n_ranges`).


