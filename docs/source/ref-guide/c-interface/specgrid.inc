.. c:function:: void load_specgrid(const char *specgrid_file_name, SpecGrid *specgrid, Stat *stat)

   Create a new :c:type:`SpecGrid` by loading data from a :f-schema:`specgrid` file.

   :param specgrid_file_name: Name of the :f-schema:`specgrid` file.
   :param specgrid: Grid object.
   :param stat: Status code (set to :c:expr:`NULL` if not required).

		
.. c:function:: void unload_specgrid(SpecGrid specgrid)

   Unload a :c:type:`specgrid` grid, freeing up memory.

   :param specgrid: Grid object.

	       
.. c:function:: void get_specgrid_rank(SpecGrid specgrid, int *rank)

   Get the rank (dimension) of the grid.

   :param specgrid: Grid object.
   :param rank: Rank.

		
.. c:function:: void get_specgrid_shape(SpecGrid specgrid, int shape[])

   Get the shape of the grid.

   :param specgrid: Grid object.
   :param rank: Shape.

		
.. c:function:: void get_specgrid_lam_min(SpecGrid specgrid, double *lam_min)

   Get the minimum wavelength of the grid.

   :param specgrid: Grid object.
   :param lam_min: Minimum wavelength (Å).


.. c:function:: void get_specgrid_lam_max(SpecGrid specgrid, double *lam_max)

   Get the maximum wavelength of the grid.

   :param specgrid: Grid object.
   :param lam_max: Maximum wavelength (Å).


.. c:function:: void get_specgrid_cache_lam_min(SpecGrid specgrid, double *cache_lam_min)

   Get the minimum wavelength of the grid cache.

   :param specgrid: Grid object.
   :param cache_lam_min: Minimum wavelength (Å).


.. c:function:: void get_specgrid_cache_lam_max(SpecGrid specgrid, double *cache_lam_max)

   Get the maximum wavelength of the grid cache.

   :param specgrid: Grid object.
   :param cache_lam_max: Maximum wavelength (Å).


.. c:function:: void get_specgrid_cache_limit(SpecGrid specgrid, int *cache_limit)

   Get the maximum memory usage of the grid cache.

   :param specgrid: Grid object.
   :param cache_limit: Maximum memory usage (MB).

		    
.. c:function:: void get_specgrid_cache_usage(SpecGrid specgrid, int *cache_usage)

   Get the current memory usage of the grid cache.

   :param specgrid: Grid object.
   :param cache_usage: Current memory usage (MB).


.. c:function:: void get_specgrid_axis_x_min(SpecGrid specgrid, int i, double *x_min)

   Get the minimum value of the i'th grid axis.

   :param specgrid: Grid object.
   :param i: Axis index (beginning at 0).
   :param x_min: Minimum value.


.. c:function:: void get_specgrid_axis_x_max(SpecGrid specgrid, int i, double *x_max)

   Get the maximum value of the i'th grid axis.

   :param specgrid: Grid object.
   :param i: Axis index (beginning at 0).
   :param x_max: Maximum value.


.. c:function:: void get_specgrid_axis_label(SpecGrid specgrid, int i, char *label)

   Get the label of the i'th grid axis.

   :param photgrid: Grid object.
   :param i: Index of the label (beginning at 0).
   :param axis_label: Buffer to store axis label (at least 17 bytes, to accomodate label plus null terminator).


.. c:function:: void set_specgrid_cache_lam_min(SpecGrid specgrid, double cache_lam_min, Stat *stat)

   Set the minimum wavelength of the grid cache.

   :param specgrid: Grid object.
   :param cache_lam_min: Minimum wavelength (Å).
   :param stat: Status code (set to :c:expr:`NULL` if not required).


.. c:function:: void set_specgrid_cache_lam_max(SpecGrid specgrid, double cache_lam_max, Stat *stat)

   Set the maximum wavelength of the grid cache.

   :param specgrid: Grid object.
   :param cache_lam_max: Maximum wavelength (Å).
   :param stat: Status code (set to :c:expr:`NULL` if not required).


.. c:function:: void set_specgrid_cache_limit(SpecGrid specgrid, int cache_limit, Stat *stat)

   Set the maximum memory usage of the grid cache.

   :param specgrid: Grid object.
   :param cache_limit: Maximum memory usage (MB).
   :param stat: Status code (set to :c:expr:`NULL` if not required).


.. c:function:: void interp_specgrid_intensity(SpecGrid specgrid, int n, int r, double x_vec[], double mu, double z, double lam[], double I[], Stat *stat, bool deriv_vec[], int *order)

   Interpolate the spectroscopic specific intensity for a photospheric element.

   :param specgrid: Grid object.
   :param n: Number of wavelength points.
   :param r: Number of photospheric parameters.
   :param x_vec[r]: Photospheric parameter values.
   :param mu: Cosine of angle of emergence relative to element normal.
   :param z: Redshift of element relative to observer's frame.
   :param lam[n]: Wavelength abscissa (Å) in observer's frame.
   :param I[n-1]: Spectroscopic specific intensity (erg/cm^2/s/Å/sr) in bins delineated by lam.
   :param stat: Status code (set to :c:expr:`NULL` if not required).
   :param deriv_vec[r]: Derivative flags (set to :c:expr:`NULL` if not required).
   :param order: Interpolation order (1 or 3; set to :c:expr:`NULL` if not required).

		  
.. c:function:: void interp_specgrid_E_moment(SpecGrid specgrid, int n, int r, double x_vec[], int k, double z, double lam[], double E[], Stat *stat, bool deriv_vec[], int *order)

   Interpolate the spectroscopic intensity E-moment for a photospheric element.

   :param specgrid: Grid object.
   :param n: Number of wavelength points.
   :param r: Number of photospheric parameters.
   :param x_vec[r]: Photospheric parameter values.
   :param k: Degree of moment.
   :param z: Redshift of element relative to obvserver's frame.
   :param lam[n]: Wavelength abscissa (Å) in observer's frame.
   :param D[n-1]: Spectroscopic intensity E-moment (erg/cm^2/s/Å) in bins delineated by lam.
   :param stat: Status code (set to :c:expr:`NULL` if not required).
   :param deriv_vec[r]: Derivative flags (set to :c:expr:`NULL` if not required).
   :param order: Interpolation order (1 or 3; set to :c:expr:`NULL` if not required).

		  
.. c:function:: void interp_specgrid_D_moment(SpecGrid specgrid, int n, int r, double x_vec[], int l, double z, double lam[], double D[], Stat *stat, bool deriv_vec[], int *order)

   Interpolate the spectroscopic intensity D-moment.

   :param specgrid: Grid object.
   :param n: Number of wavelength points.
   :param r: Number of photospheric parameters.
   :param x_vec[r]: Photospheric parameter values.
   :param l: Harmonic degree of moment.
   :param z: Redshift of element relative to observer's frame.
   :param lam[n]: Wavelength abscissa (Å) in observer's frame.
   :param D[n-1]: Spectroscopic intensity D-moment (erg/cm^2/s/Å) in bins delineated by lam.
   :param stat: Status code (set to :c:expr:`NULL` if not required).
   :param deriv_vec[r]: Derivative flags (set to :c:expr:`NULL` if not required).
   :param order: Interpolation order (1 or 3; set to :c:expr:`NULL` if not required).

		  
.. c:function:: void interp_specgrid_irradiance(SpecGrid specgrid, int n, int m, int r, double x_vec[], double mu[], double dOmega[], double z, double lam[], double F[], Stat *stat, bool deriv_vec[], int *order)

   Interpolate the spectroscopic irradiance for an object composed of multiple photospheric elements.

   :param specgrid: Grid object.
   :param n: Number of wavelength points.
   :param m: Number of elements.
   :param r: Number of photospheric parameters.
   :param x_vec[m,r]: Photospheric parameter values.
   :param mu[m]: Cosines of angles of emergence relative to element normals.
   :param dOmega[m]: Solid angles (sr) of elements.
   :param z[m]: Redshifts of elements relative to observer's frame.
   :param lam[n]: Wavelength abscissa (Å) in observer's frame.
   :param F[n-1]: Spectroscopic irradiance (erg/cm^2/s/Å) in bins delineated by lam.
   :param stat: Status code (set to :c:expr:`NULL` if not required).
   :param deriv_vec[r]: Derivative flags (set to :c:expr:`NULL` if not required).
   :param order: Interpolation order (1 or 3; set to :c:expr:`NULL` if not required).

		  
.. c:function:: void interp_specgrid_flux(SpecGrid specgrid, int n, int r, double x_vec[], double z, double lam[], double F[], Stat *stat, bool deriv_vec[], int *order)
		
   Interpolate the spectroscopic flux for a photospheric element.

   :param specgrid: Grid object.
   :param n: Number of wavelength points.
   :param r: Number of photospheric parameters.
   :param x_vec[r]: Photospheric parameter values.
   :param z: Redshift of element relative to observer's frame.
   :param lam[n]: Wavelength abscissa (Å) in observer's frame.
   :param F[n-1]: Spectroscopic flux (erg/cm^2/s/Å) in bins delineated by lam.
   :param stat: Status code (set to :c:expr:`NULL` if not required).
   :param deriv_vec[r]: Derivative flags (set to :c:expr:`NULL` if not required).
   :param order: Interpolation order (1 or 3; set to :c:expr:`NULL` if not required).


.. c:function:: void adjust_specgrid_x_vec(SpecGrid specgrid, int r, double x_vec[], double dx_vec[], double x_adj[], Stat *stat)
		
   Adjust photospheric parameters in a specified direction, until 
   they fall within a valid part of the grid.

   :param specgrid: Grid object.
   :param r: Number of photospheric parameters.
   :param x_vec[r]: Photospheric parameter values.
   :param dx_vec[r]: Photospheric parameter adjustment direction.
   	  The overall scaling is unimportant, but at least one element must be non-zero.
   :param x_adj[r]: Adjusted photospheric parameter values.
   :param stat: Status code (set to :c:expr:`NULL` if not required).
