.. _c-photgrid:

========
PhotGrid
========

.. c:type:: PhotGrid

.. c:function:: void load_photgrid(const char *photgrid_filename, PhotGrid *photgrid, int *stat)

   Load a photometric intensity grid from file.

   :param photgrid_filename: Name of the file.
   :param photgrid: Returned grid object.
   :param stat: Returned status code.

		
.. c:function:: void load_photgrid_from_specgrid(const char *specgrid_filename, const char *passband_filename, PhotGrid *photgrid, int *stat)

   Load a spectroscopic intensity grid from file, together with a
   passband, and combine dynamically to create a photometric intensity
   grid.

   :param specgrid_filename: Name of the spectroscopic intensity grid file.
   :param passband_filename: Name of the passband file.
   :param photgrid: Returned grid object.
   :param stat: Returned status code.

		
.. c:function:: void unload_photgrid(PhotGrid photgrid)

   Unload a photometric intensity grid, freeing up memory.

   :param photgrid: Grid object.

	       
.. c:function:: void get_photgrid_rank(Photgrid photgrid, int *rank)

   Get the rank (dimension) of the grid.

   :param photgrid: Grid object.
   :param rank: Returned rank.

		
.. c:function:: void get_photgrid_cache_count(Photgrid photgrid, int *cache_count)

   Get the number of nodes currently held in the grid cache.

   :param photgrid: Grid object.
   :param ceche_count: Returned number of nodes.


.. c:function:: void get_photgrid_cache_limit(Photgrid photgrid, int *cache_limit)

   Get the maximum number of nodes to hold in the grid cache.

   :param photgrid: Grid object.
   :param cache_limit: Returned maximum number of nodes.

		    
.. c:function:: void get_photgrid_axis_x_min(Photgrid photgrid, int i, double *x_min)

   Get the minimum value of the i'th grid axis.

   :param photgrid: Grid object.
   :param i: Axis index (beginning at 1).
   :param x_min: Returned minimum value.


.. c:function:: void get_photgrid_axis_x_max(Photgrid photgrid, int i, double *x_max)

   Get the maximum value of the i'th grid axis.

   :param photgrid: Grid object.
   :param i: Axis index (beginning at 1).
   :param x_max: Returned maximum value.


.. c:function:: void get_photgrid_axis_label(SpecGrid specgrid, int i, char *label)

   Get the label of the i'th grid axis.

   :param photgrid: Grid object.
   :param i: Index of the label (beginning at 1).
   :param axis_label: Buffer to store axis label buffer (at least 17 bytes, to accomodate label plus null terminator).


.. c:function:: void set_photgrid_cache_limit(Photgrid photgrid, int cache_limit, int *stat)

   Set the maximum number of notes to hold in the grid cache. Set to 0 to
   disable caching.

   :param photgrid: Grid object.
   :param cache_limit: Maximum number of nodes.
   :param stat: Returned status code (set to :c:expr:`NULL` if not required).


.. c:function:: void interp_photgrid_intensity(PhotGrid photgrid, double vx[], double mu, double *I, int *stat, bool vderiv[])

   Interpolate the photometric intensity, normalized to the zero-point flux.

   :param photgrid: Grid object.
   :param vx: Atmospheric parameter values.
   :param mu: Cosine of angle of emergence relative to surface normal.
   :param I: Returned photometric intensity (/sr).
   :param stat: Returned status code (set to :c:expr:`NULL` if not required).
   :param vderiv: Derivative flags (set to :c:expr:`NULL` if not required).

		  
.. c:function:: void interp_photgrid_E_moment(PhotGrid photgrid, double vx[], int k, double *E, int *stat, bool vderiv[])

   Interpolate the photometric intensity E-moment, normalized to the zero-point flux.

   :param photgrid: Grid object.
   :param vx: Atmospheric parameter values.
   :param k: Degree of moment.
   :param D: Returned photometric intensity E-moment.
   :param stat: Returned status code (set to :c:expr:`NULL` if not required).
   :param vderiv: Derivative flags (set to :c:expr:`NULL` if not required).
		  
		
.. c:function:: void interp_photgrid_D_moment(PhotGrid photgrid, double vx[], int l, double *D, int *stat, bool vderiv[])

   Interpolate the photometric intensity D-moment, normalized to the zero-point flux.

   :param photgrid: Grid object.
   :param vx: Atmospheric parameter values.
   :param l: Harmonic degree of moment.
   :param D: Returned photometric intensity D-moment.
   :param stat: Returned status code (set to :c:expr:`NULL` if not required).
   :param vderiv: Derivative flags (set to :c:expr:`NULL` if not required).
		  
		
.. c:function:: void interp_photgrid_flux(PhotGrid photgrid, double vx[], double *F, int *stat, bool vderiv[])

   Interpolate the photometric flux, normalized to the zero-point flux.

   :param PhotGrid: Grid object.
   :param vx: Atmospheric parameter values.
   :param F: Returned photometric flux.
   :param stat: Returned status code (set to :c:expr:`NULL` if not required).
   :param vderiv: Derivative flags (set to :c:expr:`NULL` if not required).
	       

