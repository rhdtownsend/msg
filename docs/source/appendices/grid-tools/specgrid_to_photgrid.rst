.. _grid-tools-specgrid_to_photgrid:

specgrid_to_photgrid
~~~~~~~~~~~~~~~~~~~~

The :command:`specgrid_to_photgrid` tool convolves a spectroscopic
grid with a passband to make a photometric grid, writing it to a
:f-schema:`photgrid` file. It accepts the following command-line
arguments:

.. program:: specgrid_to_photgrid

.. option:: <specgrid_file_name>

   Name of input :f-schema:`specgrid` file.

.. option:: <passband_file_name>

   Name of input :f-schema:`passband` file.

.. option:: <photgrid_file_name>

   Name of output :f-schema:`photgrid` file.

Note that it's not always necessary to create :f-schema:`photgrid`
files, as MSG can convolve with passbands on the fly (as discussed in
the :ref:`photometric-colors` section).
