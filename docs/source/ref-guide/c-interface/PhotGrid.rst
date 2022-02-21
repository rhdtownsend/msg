.. _c-photgrid:

.. c:type:: PhotGrid

.. c:function:: void load_PhotGrid(const char *photgrid_filename, PhotGrid *photgrid, int *stat)

   Load a photometric intensity grid from file.

   :param photgrid_filename: Name of the file.
   :param photgrid: Returned grid object.
   :param stat: Returned status code.

		
.. c:function:: void load_PhotGrid_from_SpecGrid(const char *specgrid_filename, const char *passband_filename, PhotGrid *photgrid, int *stat)

   Load a spectroscopic intensity grid from file, together with a
   passband, and combine dynamically to create a photometric intensity
   grid.

   :param specgrid_filename: Name of the spectroscopic intensity grid file.
   :param passband_filename: Name of the passband file.
   :param photgrid: Returned grid object.
   :param stat: Returned status code.

		
.. c:function:: void unload_PhotGrid(PhotGrid photgrid)

   Unload a photometric intensity grid, freeing up memory.

   :param photgrid: Grid object.

	       
.. c:function:: void inquire_PhotGrid(PhotGrid photgrid, int shape[], int *rank, double axis_min[], double axis_max[])

   Inquire about photometric intensity grid properties.

   :param photgrid: Grid object.
   :param shape: Returned atmospheric parameter axes lengths (set to :c:expr:`NULL` if not required).
   :param rank: Returned number of atmospheric parameters (set to :c:expr:`NULL` if not required).
   :param axis_min: Returned atmospheric parameter axis minima (set to :c:expr:`NULL` if not required).
   :param axis_max: Returned atmospheric parameter axis minima (set to :c:expr:`NULL` if not required).

		    
.. c:function:: void get_axis_label_PhotGrid(PhotGrid photgrid, int i, char *axis_label)

   Get a photometric intensity grid axis label.

   :param photgrid: Grid object.
   :param i: Index of the label (beginning at 1).
   :param axis_label: Buffer to store axis label buffer (at least 17 bytes, to accomodate label plus null terminator).

		      
.. c:function:: void interp_intensity_PhotGrid(PhotGrid photgrid, double vx[], double mu, double *I, int *stat, bool vderiv[])

   Interpolate the photometric intensity, normalized to the zero-point flux.

   :param photgrid: Grid object.
   :param vx: Atmospheric parameter values.
   :param mu: Cosine of angle of emergence relative to surface normal.
   :param I: Returned photometric intensity (/sr).
   :param stat: Returned status code (set to :c:expr:`NULL` if not required).
   :param vderiv: Derivative flags (set to :c:expr:`NULL` if not required).

		  
.. c:function:: void interp_E_moment_PhotGrid(PhotGrid photgrid, double vx[], int k, double *E, int *stat, bool vderiv[])

   Interpolate the photometric intensity E-moment, normalized to the zero-point flux.

   :param photgrid: Grid object.
   :param vx: Atmospheric parameter values.
   :param k: Degree of moment.
   :param D: Returned photometric intensity E-moment.
   :param stat: Returned status code (set to :c:expr:`NULL` if not required).
   :param vderiv: Derivative flags (set to :c:expr:`NULL` if not required).
		  
		
.. c:function:: void interp_D_moment_PhotGrid(PhotGrid photgrid, double vx[], int l, double *D, int *stat, bool vderiv[])

   Interpolate the photometric intensity D-moment, normalized to the zero-point flux.

   :param photgrid: Grid object.
   :param vx: Atmospheric parameter values.
   :param l: Harmonic degree of moment.
   :param D: Returned photometric intensity D-moment.
   :param stat: Returned status code (set to :c:expr:`NULL` if not required).
   :param vderiv: Derivative flags (set to :c:expr:`NULL` if not required).
		  
		
.. c:function:: void interp_flux_PhotGrid(PhotGrid photgrid, double vx[], double *F, int *stat, bool vderiv[])

   Interpolate the photometric flux, normalized to the zero-point flux.

   :param PhotGrid: Grid object.
   :param vx: Atmospheric parameter values.
   :param F: Returned photometric flux.
   :param stat: Returned status code (set to :c:expr:`NULL` if not required).
   :param vderiv: Derivative flags (set to :c:expr:`NULL` if not required).
	       

