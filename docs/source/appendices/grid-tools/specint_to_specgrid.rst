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

.. option:: <allow_dupes> (optional)

   Flag governing handling of duplicate grid nodes in the manifest
   file; set to :code:`T` to allow duplicates.

The manifest file is a simple text file that lists all the
:f-schema:`specint` files (one per line) that should be included in
the grid. The axes and the topology of the grid are automatically
determined by the labels attached to each :f-schema:`specint` file. If
two files have identical labels, then the one appearing later in the
manifest file is used if :option:`<allow_dupes>` is :code:`T`; otherwise, an
error is thrown.
