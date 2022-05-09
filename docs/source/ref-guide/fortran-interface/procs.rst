.. _fortran-procs:

Procedures
----------

.. f:subroutine:: load_specgrid(specgrid_file_name, specgrid, stat)

   Load a spectroscopic grid from file.

   :p character(*) specgrid_file_name [in]: Name of the file.
   :p specgrid_t specgrid [out]: Returned grid.
   :o integer stat [out]: Returned status code.

.. f:subroutine:: load_photgrid(photgrid_file_name, photgrid, stat)

   Load a photometric grid from file.

   :p character(*) photgrid_file_name [in]: Name of the file.
   :p specgrid_t photgrid [out]: Returned grid.
   :o integer stat [out]: Returned status code.

.. f:subroutine:: load_photgrid_from_specgrid(specgrid_file_name, passband_file_name, photgrid, stat)

   Load a spectroscopic grid from file, together with a
   passband, and combine dynamically to create a photometric
   grid.

   :p character(*) specgrid_file_name [in]: Name of the grid file.
   :p character(*) passband_file_name [in]: Name of the passband file.
   :p specgrid_t photgrid [out]: Returned grid.
   :o integer stat [out]: Returned status code.

.. f:subroutine:: get_version(version)

   Get the version of the MSG library

   :p character(*), allocatable version [out]: Returned version string.
