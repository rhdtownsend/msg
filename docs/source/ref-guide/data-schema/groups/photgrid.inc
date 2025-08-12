.. rst:group-schema:: photgrid

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
     - literal ``'photgrid_t'``.
   * - ``REVISION``
     - attribute
     - integer
     - literal ``1``.
   * - ``photsource/n``
     - attribute
     - integer
     - number of photints.
   * - ``photsource/photints[i]``
     - group
     - :g-schema:`limb_photint`
     - grid photints (``i = 1, ..., n``).
   * - ``vgrid``
     - group
     - :g-schema:`vgrid`
     - virtual grid.
