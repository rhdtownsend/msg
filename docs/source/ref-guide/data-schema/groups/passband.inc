.. rst:group-schema:: passband

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
     - literal :code:`'passband_t'`.
   * - :code:`REVISION`
     - attribute
     - integer
     - literal :code:`1`.
   * - :code:`F_0`
     - attribute
     - real
     - normalizing flux (erg/cm^2/s).
   * - :code:`cubint`
     - group
     - :g-schema:`cubint`
     - filter interpolant.
