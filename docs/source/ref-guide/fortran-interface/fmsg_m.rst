.. _fortran-fmsg-m:

.. f:module:: fmsg_m

.. f:subroutine:: load_specgrid(specgrid_filename, specgrid, stat)

   Load a spectroscopic intensity grid from file.

   :p character(*) spegrid_filename [in]: Name of the file.
   :p specgrid_t specgrid [out]: Returned grid object.

   :o integer stat [out]: Returned status code.

.. f:subroutine:: load_photgrid(photgrid_filename, photgrid, stat)

   Load a photometric intensity grid from file.

   :p character(*) spegrid_filename [in]: Name of the file.
   :p photgrid_t photgrid [out]: Returned grid object.

   :o integer stat [out]: Returned status code.

.. f:subroutine:: load_photgrid_from_specgrid(specgrid_filename, photgrid_filename, photgrid, stat)

   Load a spectroscopic intensity grid from file, together with a
   passband, and combine dynamically to create a photometric intensity
   grid.

   :p character(*) spegrid_filename [in]: Name of the specgrid file.
   :p character(*) passband_filename [in]: Name of the passband file.
   :p photgrid_t photgrid [out]: Returned grid object.

   :o integer stat [out]: Returned status code.
			   
