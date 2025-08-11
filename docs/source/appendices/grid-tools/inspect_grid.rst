.. _grid-tools-inspect_grid:

inspect_grid
~~~~~~~~~~~~

.. program:: inspect_grid

Synopsis
--------

.. code-block:: text

   inspect_grid GRID_FILE [options]

Description
-----------

The :program:`inspect_grid` tool extracts metadata from a :f-schema:`specgrid` or
:f-schema:`photgrid` file, and prints it to standard output.

Options
-------

.. option:: -h, --help

   Print a summary of options.

.. option:: -t, --type

   Print the grid type.

.. option:: -l, --label

   Print the grid label (if defined).

.. option:: -x, --axes

   Print the grid axes information.

.. option::  --lambda

   Print the grid wavelength information (only for
   :f-schema:`specgrid` files).

.. option:: -a, --all

   Equivalent to specifying :option:`--type`, :option:`--label`,
   :option:`--axes` and :option:`--lambda`.
