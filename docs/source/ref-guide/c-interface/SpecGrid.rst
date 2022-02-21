.. _c-specgrid:

.. c:type:: SpecGrid

.. c:function:: void load_SpecGrid(const char *specgrid_filename, SpecGrid *specgrid, int *stat)

   Load a spectroscopic intensity grid from file.

   :param specgrid_filename: Name of the file.
   :param specgrid: Returned grid object.
   :param stat: Returned status code.

		
.. c:function:: void c_unload_SpecGrid(SpecGrid specgrid)

   Unload a spectroscopic intensity grid, freeing up memory.

   :param specgrid: Grid to unload.

	       
.. c:function:: void inquire_SpecGrid(SpecGrid specgrid, double *lam_min, double *lam_max, int shape[], int *rank, double axis_min[], double axis_max[])

   Inquire about spectroscopic intensity grid properties.

   :param specgrid: Grid object.
   :param lam_min: Returned wavelength abscissa minimum (set to :c:expr:`NULL` if not required).
   :param lam_min: Returned wavelength abscissa maximum (set to :c:expr:`NULL` if not required).
   :param shape: Returned atmospheric parameter axes lengths (set to :c:expr:`NULL` if not required).
   :param rank: Returned number of atmospheric parameters (set to :c:expr:`NULL` if not required).
   :param axis_min: Returned atmospheric parameter axis minima (set to :c:expr:`NULL` if not required).
   :param axis_max: Returned atmospheric parameter axis minima (set to :c:expr:`NULL` if not required).

		    
.. c:function:: void get_axis_label_SpecGrid(SpecGrid specgrid, int i, char *axis_label)

   Get a spectroscopic intensity grid axis label.

   :param specgrid: Grid object.
   :param i: Index of the label (beginning at 1).
   :param axis_label: Buffer to store axis label buffer (at least 17 bytes, to accomodate label plus null terminator).

		      
.. c:function:: void interp_intensity_SpecGrid(SpecGrid specgrid, double vx[], double mu, int n, double lam[], double I[], int *stat, bool vderiv[])

   Interpolate the spectroscopic intensity.

   :param specgrid: Grid object.
   :param vx: Atmospheric parameter values.
   :param mu: Cosine of angle of emergence relative to surface normal.
   :param n: Number of points in wavelength abscissa.
   :param lam[n]: Wavelength abscissa (Å).
   :param I[n-1]: Returned spectroscopic intensity (erg/cm^2/s/Å/sr) in bins delineated by lam
   :param stat: Returned status code (set to :c:expr:`NULL` if not required).
   :param vderiv: Derivative flags (set to :c:expr:`NULL` if not required).

		  
.. c:function:: void interp_E_moment_SpecGrid(SpecGrid specgrid, double vx[], int k, int n, double lam[], double E[], int *stat, bool vderiv[])

   Interpolate the spectroscopic intensity E-moment.

   :param specgrid: Grid object.
   :param vx: Atmospheric parameter values.
   :param k: Degree of moment.
   :param n: Number of points in wavelength abscissa.
   :param lam[n]: Wavelength abscissa (Å).
   :param D[n-1]: Returned spectroscopic intensity E-moment (erg/cm^2/s/Å) in bins delineated by lam
   :param stat: Returned status code (set to :c:expr:`NULL` if not required).
   :param vderiv: Derivative flags (set to :c:expr:`NULL` if not required).

		  
.. c:function:: void interp_D_moment_SpecGrid(SpecGrid specgrid, double vx[], int l, int n, double lam[], double D[], int *stat, bool vderiv[])

   Interpolate the spectroscopic intensity D-moment.

   :param specgrid: Grid object.
   :param vx: Atmospheric parameter values.
   :param l: Harmonic degree of moment.
   :param n: Number of points in wavelength abscissa.
   :param lam[n]: Wavelength abscissa (Å).
   :param D[n-1]: Returned spectroscopic intensity D-moment (erg/cm^2/s/Å) in bins delineated by lam
   :param stat: Returned status code (set to :c:expr:`NULL` if not required).
   :param vderiv: Derivative flags (set to :c:expr:`NULL` if not required).

		  
.. c:function:: void interp_flux_SpecGrid(SpecGrid specgrid, double vx[], int n, double lam[], double F[], int *stat, bool vderiv[])
		
   Interpolate the spectroscopic flux.

   :param specgrid: Grid object.
   :param vx: Atmospheric parameter values.
   :param n: Number of points in wavelength abscissa.
   :param lam[n]: Wavelength abscissa (Å).
   :param F[n-1]: Returned spectroscopic flux (erg/cm^2/s/Å) in bins delineated by lam
   :param stat: Returned status code (set to :c:expr:`NULL` if not required).
   :param vderiv: Derivative flags (set to :c:expr:`NULL` if not required).

