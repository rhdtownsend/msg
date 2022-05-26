.. _fortran-procs:

Procedures
----------

.. f:subroutine:: load_specgrid(specgrid_file_name, specgrid, stat)

   Create a new :f:type:`specgrid_t` by loading data from a `specgrid` file.

   :p character(*) specgrid_file_name [in]: Name of the `specgrid` file.
   :p specgrid_t specgrid [out]: Returned grid.
   :o integer stat [out]: Returned status code.

.. f:subroutine:: load_photgrid(photgrid_file_name, photgrid, stat)

   Create a new :f:type:`photgrid_t` by loading data from a `photgrid` file.

   :p character(*) photgrid_file_name [in]: Name of the `photgrid` file.
   :p specgrid_t photgrid [out]: Returned grid.
   :o integer stat [out]: Returned status code.

.. f:subroutine:: load_photgrid_from_specgrid(specgrid_file_name, passband_file_name, photgrid, stat)

   Create a new :f:type:`photgrid_t` by loading data from a `specgrid` file,
   and convolving on-the-fly with a passband response function also loaded from file.

   :p character(*) specgrid_file_name [in]: Name of the `specgrid` file.
   :p character(*) passband_file_name [in]: Name of the passband file.
   :p specgrid_t photgrid [out]: Returned grid.
   :o integer stat [out]: Returned status code.

.. f:subroutine:: get_version(version)

   Get the version of the MSG library

   :p character(*), allocatable version [out]: Returned version string.
