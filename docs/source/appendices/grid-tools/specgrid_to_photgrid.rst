.. _grid-tools-specgrid_to_photgrid:

specgrid_to_photgrid
~~~~~~~~~~~~~~~~~~~~

.. program:: specgrid_to_photgrid

Synopsis
--------

.. code-block:: text

   specgrid_to_photgrid <input_file_name> <passband_file_name> <output_file_name>

Description
-----------

The :command:`specgrid_to_photgrid` tool reads a :f-schema:`specgrid`
file, convolves it with a passband from a :f-schema:`passband` file,
and writes the data to a :f-schema:`photgrid` file.

.. note::

   It's not always necessary to create :f-schema:`photgrid`
   files, as MSG can convolve with passbands on the fly (as discussed in
   the :ref:`photometric-colors` section).
