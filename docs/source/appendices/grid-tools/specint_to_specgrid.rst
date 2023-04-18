.. _grid-tools-specint_to_specgrid:

specint_to_specgrid
~~~~~~~~~~~~~~~~~~~

The :command:`specint_to_specgrid` tool packages together multiple
:f-schema:`specint` files to make a spectroscopic grid, writing it to a
:f-schema:`specgrid`. It accepts the following command-line arguments:

.. program:: specint_to_specgrid

.. option:: <manifest_file_name>

   Name of input manifest file (see below).

.. option:: <specgrid_file_name>

   Name of output :f-schema:`specgrid` file.

The manifest file is a simple text file that lists all the
:f-schema:`specint` files (one per line) that should be included in
the grid. The axes and the topology of the grid are automatically
determined by the labels attached to each :f-schema:`specint` file. If
two files have identical labels, then the one appearing first in the
manifest file is used.
