.. _c-interface:

***********
C Interface
***********

.. c:function:: void load_specgrid(const char *specgrid_filename, specgrid_t *specgrid, int *stat)

   Load a spectroscopic intensity grid from file.

   :param specgrid_filename: Name of the file.
   :param specgrid: Returned grid object.
   :param stat: Returned status code.

		
.. c:function:: void c_unload_specgrid(specgrid_t specgrid)

   Unload a spectroscopic intensity grid, freeing up memory.

   :param specgrid: Grid to unload.

	       
.. c:function:: void inquire_specgrid(specgrid_t specgrid, double *lam_min, double *lam_max, int shape[], int *rank, double axis_min[], double axis_max[])

   Inquire about spectroscopic intensity grid properties.

   :param specgrid: Grid object.
   :param lam_min: Returned wavelength abscissa minimum (set to :c:expr:`NULL` if not required).
   :param lam_min: Returned wavelength abscissa maximum (set to :c:expr:`NULL` if not required).
   :param shape: Returned atmospheric parameter axes lengths (set to :c:expr:`NULL` if not required).
   :param rank: Returned number of atmospheric parameters (set to :c:expr:`NULL` if not required).
   :param axis_min: Returned atmospheric parameter axis minima (set to :c:expr:`NULL` if not required).
   :param axis_max: Returned atmospheric parameter axis minima (set to :c:expr:`NULL` if not required).

		    
.. c:function:: void get_axis_label_specgrid(specgrid_t specgrid, int i, char *axis_label)

   Get a spectroscopic intensity grid axis label.

   :param specgrid: Grid object.
   :param i: Index of the label (beginning at 1).
   :param axis_label: Buffer to store axis label buffer (at least 17 bytes, to accomodate label plus null terminator).

		      
.. c:function:: void interp_intensity_specgrid(specgrid_t specgrid, double vx[], double mu, int n, double lam[], double I[], int *stat, bool vderiv[])

   Interpolate the spectroscopic intensity.

   :param specgrid: Grid object.
   :param vx: Atmospheric parameter values.
   :param mu: Cosine of angle of emergence relative to surface normal.
   :param n: Number of points in wavelength abscissa.
   :param lam[n]: Wavelength abscissa (Å).
   :param I[n-1]: Returned spectroscopic intensity (erg/cm^2/s/Å/sr) in bins delineated by lam
   :param stat: Returned status code (set to :c:expr:`NULL` if not required).
   :param vderiv: Derivative flags (set to :c:expr:`NULL` if not required).

		  
.. c:function:: void interp_d_moment_specgrid(specgrid_t specgrid, double vx[], int l, int n, double lam[], double D[], int *stat, bool vderiv[])

   Interpolate the spectroscopic intensity moment.

   :param specgrid: Grid object.
   :param vx: Atmospheric parameter values.
   :param l: Harmonic degree of moment.
   :param n: Number of points in wavelength abscissa.
   :param lam[n]: Wavelength abscissa (Å).
   :param D[n-1]: Returned spectroscopic intensity moment (erg/cm^2/s/Å) in bins delineated by lam
   :param stat: Returned status code (set to :c:expr:`NULL` if not required).
   :param vderiv: Derivative flags (set to :c:expr:`NULL` if not required).

		  
.. c:function:: void interp_flux_specgrid(specgrid_t specgrid, double vx[], int n, double lam[], double F[], int *stat, bool vderiv[])
		
   Interpolate the spectroscopic flux.

   :param specgrid: Grid object.
   :param vx: Atmospheric parameter values.
   :param n: Number of points in wavelength abscissa.
   :param lam[n]: Wavelength abscissa (Å).
   :param F[n-1]: Returned spectroscopic flux (erg/cm^2/s/Å) in bins delineated by lam
   :param stat: Returned status code (set to :c:expr:`NULL` if not required).
   :param vderiv: Derivative flags (set to :c:expr:`NULL` if not required).


.. c:function:: void load_photgrid(const char *photgrid_filename, photgrid_t *photgrid, int *stat)

   Load a photometric intensity grid from file.

   :param photgrid_filename: Name of the file.
   :param photgrid: Returned grid object.
   :param stat: Returned status code.

		
.. c:function:: void load_photgrid_from_specgrid(const char *specgrid_filename, const char *passband_filename, photgrid_t *photgrid, int *stat)

   Load a spectroscopic intensity grid from file, together with a
   passband, and combine dynamically to create a photometric intensity
   grid.

   :param specgrid_filename: Name of the spectroscopic intensity grid file.
   :param passband_filename: Name of the passband file.
   :param photgrid: Returned grid object.
   :param stat: Returned status code.

		
.. c:function:: void unload_photgrid(photgrid_t photgrid)

   Unload a photometric intensity grid, freeing up memory.

   :param photgrid: Grid object.

	       
.. c:function:: void inquire_photgrid(photgrid_t photgrid, int shape[], int *rank, double axis_min[], double axis_max[])

   Inquire about photometric intensity grid properties.

   :param photgrid: Grid object.
   :param shape: Returned atmospheric parameter axes lengths (set to :c:expr:`NULL` if not required).
   :param rank: Returned number of atmospheric parameters (set to :c:expr:`NULL` if not required).
   :param axis_min: Returned atmospheric parameter axis minima (set to :c:expr:`NULL` if not required).
   :param axis_max: Returned atmospheric parameter axis minima (set to :c:expr:`NULL` if not required).

		    
.. c:function:: void get_axis_label_photgrid(photgrid_t photgrid, int i, char *axis_label)

   Get a photometric intensity grid axis label.

   :param photgrid: Grid object.
   :param i: Index of the label (beginning at 1).
   :param axis_label: Buffer to store axis label buffer (at least 17 bytes, to accomodate label plus null terminator).

		      
.. c:function:: void interp_intensity_photgrid(photgrid_t photgrid, double vx[], double mu, double *I, int *stat, bool vderiv[])

   Interpolate the photometric intensity.

   :param photgrid: Grid object.
   :param vx: Atmospheric parameter values.
   :param mu: Cosine of angle of emergence relative to surface normal.
   :param I: Returned photometric intensity (erg/cm^2/s/sr).
   :param stat: Returned status code (set to :c:expr:`NULL` if not required).
   :param vderiv: Derivative flags (set to :c:expr:`NULL` if not required).

		  
.. c:function:: void interp_d_moment_photgrid(photgrid_t photgrid, double vx[], int l, double *D, int *stat, bool vderiv[])

   Interpolate the photometric intensity moment.

   :param photgrid: Grid object.
   :param vx: Atmospheric parameter values.
   :param l: Harmonic degree of moment.
   :param D: Returned photometric intensity moment (erg/cm^2/s).
   :param stat: Returned status code (set to :c:expr:`NULL` if not required).
   :param vderiv: Derivative flags (set to :c:expr:`NULL` if not required).
		  
		
.. c:function:: void interp_flux_photgrid(photgrid_t photgrid, double vx[], double *F, int *stat, bool vderiv[])

   Interpolate the photometric flux.

   :param photgrid_t: Grid object.
   :param vx: Atmospheric parameter values.
   :param F: Returned photometric flux (erg/cm^2/s).
   :param stat: Returned status code (set to :c:expr:`NULL` if not required).
   :param vderiv: Derivative flags (set to :c:expr:`NULL` if not required).


