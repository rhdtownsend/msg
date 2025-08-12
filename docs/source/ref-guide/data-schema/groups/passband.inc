.. rst:group-schema:: passband

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
     - literal ``'passband_t'``.
   * - ``REVISION``
     - attribute
     - integer
     - literal ``1``.
   * - ``F_0``
     - attribute
     - real
     - normalizing flux (erg/cm^2/s).
   * - ``cubint``
     - group
     - :g-schema:`cubint`
     - filter interpolant.
