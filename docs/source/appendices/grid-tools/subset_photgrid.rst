.. _grid-tools-subset_photgrid:

subset_photgrid
~~~~~~~~~~~~~~~

.. program:: subset_photgrid

Synopsis
--------

.. code-block:: text

   subset_photgrid INPUT_FILE OUTPUT_FILE [options]

Description
-----------

The :program:`subset_photgrid` tool reads a :f-schema:`photgrid` file,
subsets it in photospheric parameter space and wavelength space, and
then writes it to a :f-schema:`photgrid` file.

Options
-------

.. option:: -h, --help

   Print a summary of options.

.. option:: -p, --parameter-range=NAME:MIN:MAX

   Photospheric parameter range.

.. option:: -r, --remove-orphans

   Remove orphaned vertices from the grid. This can reduce the output
   file size.

.. option:: -c, --compress-axes

   Compress grid axes, ensuring that the axis ranges reflect the
   available interpolation domain.

.. option:: -l --grid-label=NAME

   Set the grid label.
