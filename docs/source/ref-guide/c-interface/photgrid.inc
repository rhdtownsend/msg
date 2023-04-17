.. c:function:: void load_photgrid(const char *photgrid_file_name, PhotGrid *photgrid, int *stat)

   Create a new :c:type:`PhotGrid` by loading data from a :f-schema:`photgrid` file.

   :param photgrid_file_name: Name of the :f-schema:`photgrid` file.
   :param photgrid: Grid object.
   :param stat: Status code (set to :c:expr:`NULL` if not required).

		
.. c:function:: void load_photgrid_from_specgrid(const char *specgrid_file_name, const char *passband_file_name, PhotGrid *photgrid, int *stat)

   Create a new :c:type:`PhotGrid` by loading data from a :f-schema:`specgrid` file,
   and convolving on-the-fly with a response function loaded from a :f-schema:`passband` file.

   :param specgrid_file_name: Name of the :f-schema:`specgrid` file.
   :param passband_file_name: Name of the :f-schema:`passband` file.
   :param photgrid: Grid object.
   :param stat: Status code (set to :c:expr:`NULL` if not required).

		
.. c:function:: void unload_photgrid(PhotGrid photgrid)

   Unload a photometric grid, freeing up memory.

   :param photgrid: Grid object.

	       
.. c:function:: void get_photgrid_rank(Photgrid photgrid, int *rank)

   Get the rank (dimension) of the grid.

   :param photgrid: Grid object.
   :param rank: Rank.

		
.. c:function:: void get_photgrid_shape(Photgrid photgrid, int shaope[])

   Get the shape of the grid.

   :param photgrid: Grid object.
   :param rank: Shape.

		
.. c:function:: void get_photgrid_cache_usage(Photgrid photgrid, int *cache_usage)

   Get the current memory usage of the grid cache.

   :param photgrid: Grid object.
   :param cache_usage: Current memory usage (MB).
 

.. c:function:: void get_photgrid_cache_limit(Photgrid photgrid, int *cache_limit)

   Get the maximum memory usage of the grid cache.

   :param photgrid: Grid object.
   :param cache_limit: Maximum memory usage (MB).

		    
.. c:function:: void get_photgrid_axis_x_min(Photgrid photgrid, int i, double *x_min)

   Get the minimum value of the i'th grid axis.

   :param photgrid: Grid object.
   :param i: Axis index (beginning at 0).
   :param x_min: Minimum value.


.. c:function:: void get_photgrid_axis_x_max(Photgrid photgrid, int i, double *x_max)

   Get the maximum value of the i'th grid axis.

   :param photgrid: Grid object.
   :param i: Axis index (beginning at 0).
   :param x_max: Maximum value.


.. c:function:: void get_photgrid_axis_label(SpecGrid specgrid, int i, char *label)

   Get the label of the i'th grid axis.

   :param photgrid: Grid object.
   :param i: Index of the label (beginning at 0).
   :param axis_label: Buffer to store axis label (at least 17 bytes, to accomodate label plus null terminator).


.. c:function:: void set_photgrid_cache_limit(Photgrid photgrid, int cache_limit, int *stat)

   Set the maximum memory usage of the grid cache.

   :param photgrid: Grid object.
   :param cache_limit: Maximum memory usage (MB).
   :param stat: Status code (set to :c:expr:`NULL` if not required).


.. c:function:: void interp_photgrid_intensity(PhotGrid photgrid, double x_vec[], double mu, double *I, int *stat, bool deriv_vec[])

   Interpolate the photometric intensity, normalized to the zero-point flux.

   :param photgrid: Grid object.
   :param x_vec: Photospheric parameter values.
   :param mu: Cosine of angle of emergence relative to surface normal.
   :param I: Photometric intensity (/sr).
   :param stat: Status code (set to :c:expr:`NULL` if not required).
   :param deriv_vec: Derivative flags (set to :c:expr:`NULL` if not required).

		  
.. c:function:: void interp_photgrid_E_moment(PhotGrid photgrid, double x_vec[], int k, double *E, int *stat, bool deriv_vec[])

   Interpolate the photometric intensity E-moment, normalized to the zero-point flux.

   :param photgrid: Grid object.
   :param x_vec: Photospheric parameter values.
   :param k: Degree of moment.
   :param D: Photometric intensity E-moment.
   :param stat: Status code (set to :c:expr:`NULL` if not required).
   :param deriv_vec: Derivative flags (set to :c:expr:`NULL` if not required).
		  
		
.. c:function:: void interp_photgrid_D_moment(PhotGrid photgrid, double x_vec[], int l, double *D, int *stat, bool deriv_vec[])

   Interpolate the photometric intensity D-moment, normalized to the zero-point flux.

   :param photgrid: Grid object.
   :param x_vec: Photospheric parameter values.
   :param l: Harmonic degree of moment.
   :param D: Photometric intensity D-moment.
   :param stat: Status code (set to :c:expr:`NULL` if not required).
   :param deriv_vec: Derivative flags (set to :c:expr:`NULL` if not required).
		  
		
.. c:function:: void interp_photgrid_flux(PhotGrid photgrid, double x_vec[], double *F, int *stat, bool deriv_vec[])

   Interpolate the photometric flux, normalized to the zero-point flux.

   :param PhotGrid: Grid object.
   :param x_vec: Photospheric parameter values.
   :param F: Photometric flux.
   :param stat: Status code (set to :c:expr:`NULL` if not required).
   :param deriv_vec: Derivative flags (set to :c:expr:`NULL` if not required).


.. c:function:: void adjust_photgrid_x_vec(PhotGrid photgrid, double x_vec[], double dx_vec[], double x_adj[], Stat *stat)
		
   Adjust photospheric parameters in a specified direction, until 
   they fall within a valid part of the grid.

   :param photgrid: Grid object.
   :param x_vec: Photospheric parameter values.
   :param dx_vec: Photospheric parameter adjustment direction.
   	  The overall scaling is unimportant, but at least one element must be non-zero.
   :param x_adj: Adjusted photospheric parameter values.
   :param stat: Status code (set to :c:expr:`NULL` if not required).
