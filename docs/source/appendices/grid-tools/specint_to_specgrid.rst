.. _grid-tools-specint_to_specgrid:

specint_to_specgrid
~~~~~~~~~~~~~~~~~~~

.. program:: specint_to_specgrid

Synopsis
--------

.. code-block:: text

   specint_to_specgrid MANIFEST_FILE SPECGRID_FILE [options]

Description
-----------

The :command:`specint_to_specgrid` tool packages together multiple
:f-schema:`specint` files to make a spectroscopic grid, writing it to a
:f-schema:`specgrid`.

The input manifest file is a simple text file that lists all the
:f-schema:`specint` files (one per line) that should be included in
the grid. The axes and the topology of the grid are automatically
determined by the labels attached to each :f-schema:`specint` file. If
two files have identical labels, then the one appearing first in the
manifest file is used.
	  
Options
-------

.. option:: -h, --help

   Print a summary of options.

.. option:: -l --grid-label=NAME.

   Set the grid label.
