.. _grid-tools-subset_specgrid:

subset_specgrid
~~~~~~~~~~~~~~~

.. program:: subset_specgrid

Synopsis
--------

.. code-block:: text

   subset_specgrid INPUT_FILE OUTPUT_FILE [options]

Description
-----------

The :program:`subset_specgrid` tool reads a :f-schema:`specgrid` file,
subsets it in photospheric parameter space and wavelength space, and
then writes it to a :f-schema:`specgrid` file.

Options
-------

.. option:: -h, --help

   Print a summary of options.

.. option:: --lambda-min=MIN

   Minimum wavelength (:math:`\angstrom`).

.. option:: --lambda-max=MAX

   Maximum wavelength (:math:`\angstrom`).

.. option:: -p, --parameter-range=NAME:MIN:MAX

   Photospheric parameter range.

.. option:: -r, --remove-orphans

   Remove orphaned vertices from the grid. This can reduce the output
   file size.

.. option:: -l --grid-label=NAME

   Set the grid label.
