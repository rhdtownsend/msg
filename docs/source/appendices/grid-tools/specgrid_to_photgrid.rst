.. _grid-tools-specgrid_to_photgrid:

specgrid_to_photgrid
~~~~~~~~~~~~~~~~~~~~

.. program:: specgrid_to_photgrid

Synopsis
--------

.. code-block:: text

   specgrid_to_photgrid SPECGRID_FILE PASSBAND_FILE PHOTGRID_FILE [options]

Description
-----------

The :program:`specgrid_to_photgrid` tool reads a :f-schema:`specgrid`
file, convolves it with a passband from a :f-schema:`passband` file,
and writes the data to a :f-schema:`photgrid` file.

Options
-------

.. option:: -h, --help

   Print a summary of options.

.. option:: -r, --remove-orphans

   Remove orphaned vertices from the grid. This can reduce the output
   file size.

.. option:: -l --grid-label=NAME

   Set the grid label.

.. note::

   It's not always necessary to create :f-schema:`photgrid` files,
   because MSG can convolve with passbands on the fly (as discussed in
   the :ref:`data-files-importing` section).
