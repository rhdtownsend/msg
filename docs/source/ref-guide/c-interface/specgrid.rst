.. _c-specgrid:

SpecGrid Functions
~~~~~~~~~~~~~~~~~~

.. c:function:: void load_specgrid(const char *specgrid_file_name, SpecGrid *specgrid, int *stat)

   Load a spectroscopic grid from file.

   :param specgrid_file_name: Name of the file.
   :param specgrid: Returned grid object.
   :param stat: Returned status code.

		
.. c:function:: void unload_specgrid(SpecGrid specgrid)

   Unload a spectroscopic grid, freeing up memory.

   :param specgrid: Grid to unload.

	       
.. c:function:: void get_specgrid_rank(SpecGrid specgrid, int *rank)

   Get the rank (dimension) of the grid.

   :param specgrid: Grid object.
   :param rank: Returned rank.

		
.. c:function:: void get_specgrid_lam_min(SpecGrid specgrid, double *lam_min)

   Get the minimum wavelength of the grid.

   :param specgrid: Grid object.
   :param lam_min: Returned minimum wavelength.


.. c:function:: void get_specgrid_lam_max(SpecGrid specgrid, double *lam_max)

   Get the maximum wavelength of the grid.

   :param specgrid: Grid object.
   :param lam_max: Returned maximum wavelength.


.. c:function:: void get_specgrid_cache_lam_min(SpecGrid specgrid, double *cache_lam_min)

   Get the minimum wavelength of the grid cache.

   :param specgrid: Grid object.
   :param cache_lam_min: Returned minimum wavelength.


.. c:function:: void get_specgrid_cache_lam_max(SpecGrid specgrid, double *cache_lam_max)

   Get the maximum wavelength of the grid cache.

   :param specgrid: Grid object.
   :param cache_lam_max: Returned maximum wavelength.


.. c:function:: void get_specgrid_cache_count(SpecGrid specgrid, int *cache_count)

   Get the number of nodes currently held in the grid cache.

   :param specgrid: Grid object.
   :param cache_count: Returned number of nodes.


.. c:function:: void get_specgrid_cache_limit(SpecGrid specgrid, int *cache_limit)

   Get the maximum number of nodes to hold in the grid cache.

   :param specgrid: Grid object.
   :param cache_limit: Returned maximum number of nodes.

		    
.. c:function:: void get_specgrid_axis_x_min(SpecGrid specgrid, int i, double *x_min)

   Get the minimum value of the i'th grid axis.

   :param specgrid: Grid object.
   :param i: Axis index (beginning at 0).
   :param x_min: Returned minimum value.


.. c:function:: void get_specgrid_axis_x_max(SpecGrid specgrid, int i, double *x_max)

   Get the maximum value of the i'th grid axis.

   :param specgrid: Grid object.
   :param i: Axis index (beginning at 0).
   :param x_max: Returned maximum value.


.. c:function:: void get_specgrid_axis_label(SpecGrid specgrid, int i, char *label)

   Get the label of the i'th grid axis.

   :param photgrid: Grid object.
   :param i: Index of the label (beginning at 0).
   :param axis_label: Buffer to store axis label buffer (at least 17 bytes, to accomodate label plus null terminator).


.. c:function:: void set_specgrid_cache_lam_min(SpecGrid specgrid, double cache_lam_min, int *stat)

   Set the minimum wavelength of the grid cache.

   :param specgrid: Grid object.
   :param cache_lam_min: Minimum wavelength.
   :param stat: Returned status code (set to :c:expr:`NULL` if not required).


.. c:function:: void set_specgrid_cache_lam_max(SpecGrid specgrid, double cache_lam_max, int *stat)

   Set the maximum wavelength of the grid cache.

   :param specgrid: Grid object.
   :param cache_lam_max: Maximum wavelength.
   :param stat: Returned status code (set to :c:expr:`NULL` if not required).


.. c:function:: void set_specgrid_cache_limit(SpecGrid specgrid, int cache_limit, int *stat)

   Set the maximum number of notes to hold in the grid cache. Set to 0 to
   disable caching.

   :param specgrid: Grid object.
   :param cache_limit: Maximum number of nodes.
   :param stat: Returned status code (set to :c:expr:`NULL` if not required).


.. c:function:: void interp_specgrid_intensity(SpecGrid specgrid, double x_vec[], double mu, int n, double lam[], double I[], int *stat, bool vderiv[])

   Interpolate the spectroscopic intensity.

   :param specgrid: Grid object.
   :param x_vec: Atmospheric parameter values.
   :param mu: Cosine of angle of emergence relative to surface normal.
   :param n: Number of points in wavelength abscissa.
   :param lam[n]: Wavelength abscissa (Å).
   :param I[n-1]: Returned spectroscopic intensity (erg/cm^2/s/Å/sr) in bins delineated by lam
   :param stat: Returned status code (set to :c:expr:`NULL` if not required).
   :param deriv_vec: Derivative flags (set to :c:expr:`NULL` if not required).

		  
.. c:function:: void interp_specgrid_E_moment(SpecGrid specgrid, double x_vec[], int k, int n, double lam[], double E[], int *stat, bool deriv_vec[])

   Interpolate the spectroscopic intensity E-moment.

   :param specgrid: Grid object.
   :param x_vec: Atmospheric parameter values.
   :param k: Degree of moment.
   :param n: Number of points in wavelength abscissa.
   :param lam[n]: Wavelength abscissa (Å).
   :param D[n-1]: Returned spectroscopic intensity E-moment (erg/cm^2/s/Å) in bins delineated by lam
   :param stat: Returned status code (set to :c:expr:`NULL` if not required).
   :param deriv_vec: Derivative flags (set to :c:expr:`NULL` if not required).

		  
.. c:function:: void interp_specgrid_D_moment(SpecGrid specgrid, double x_vec[], int l, int n, double lam[], double D[], int *stat, bool deriv_vec[])

   Interpolate the spectroscopic intensity D-moment.

   :param specgrid: Grid object.
   :param x_vec: Atmospheric parameter values.
   :param l: Harmonic degree of moment.
   :param n: Number of points in wavelength abscissa.
   :param lam[n]: Wavelength abscissa (Å).
   :param D[n-1]: Returned spectroscopic intensity D-moment (erg/cm^2/s/Å) in bins delineated by lam
   :param stat: Returned status code (set to :c:expr:`NULL` if not required).
   :param deriv_vec: Derivative flags (set to :c:expr:`NULL` if not required).

		  
.. c:function:: void interp_specgrid_flux(SpecGrid specgrid, double x_vec[], int n, double lam[], double F[], int *stat, bool deriv_vec[])
		
   Interpolate the spectroscopic flux.

   :param specgrid: Grid object.
   :param x_vec: Atmospheric parameter values.
   :param n: Number of points in wavelength abscissa.
   :param lam[n]: Wavelength abscissa (Å).
   :param F[n-1]: Returned spectroscopic flux (erg/cm^2/s/Å) in bins delineated by lam
   :param stat: Returned status code (set to :c:expr:`NULL` if not required).
   :param deriv_vec: Derivative flags (set to :c:expr:`NULL` if not required).

