.. f:type:: specgrid_t

   The specgrid_t type represents a grid of spectroscopic data.

   This grid may be used to interpolate the intensity (or related
   quantities) across a wavelength abscissa and for a set of
   photospheric parameter values.


   .. f:subroutine:: get_rank(rank)

      Get the rank (dimension) of the grid.

      :p integer rank [out]: Rank.


   .. f:subroutine:: get_shape(shape)

      Get the shape of the grid.

      :p integer shape(:) [out]: Shape; length `rank`.


   .. f:subroutine:: get_axis(i, axis)

      Get an axis of the grid.

      :p integer i [in]: Index of axis (between 1 and `rank`).
      :p axis_t axis [out]: Axis.


   .. f:subroutine:: get_lam_min(lam_min)

      Get the minimum wavelength of the grid.

      :p real(RD) lam_min [out]: Minimum wavelength (Å).


   .. f:subroutine:: get_lam_max(lam_max)

      Get the maximum wavelength of the grid.

      :p real(RD) lam_max [out]: Maximum wavelength (Å).


   .. f:subroutine:: get_cache_lam_min(cache_lam_min)

      Get the minimum wavelength of the grid cache.

      :p real(RD) lam_min [out]: Minimum wavelength (Å). 


   .. f:subroutine:: get_cache_lam_max(cache_lam_max)

      Get the maximum wavelength of the grid cache.

      :p real(RD) cache_lam_max [out]: Maximum wavelength (Å).


   .. f:subroutine:: get_cache_limit(cache_limit)

      Get the maximum memory usage of the grid cache.

      :p integer cache_limit [out]: Maximum memory usage (MB).


   .. f:subroutine:: get_cache_usage(cache_usage)

      Get the current memory usage of the grid cache.

      :p integer cache_usage [out]: Current memory usage (MB)

      
   .. f:subroutine:: set_cache_lam_min(cache_lam_min, stat)

      Set the minimum wavelength of the grid cache.

      :p real(RD) lam_min [in]: Minimum wavelength (Å).
      :o integer stat [out]: Status code.


   .. f:subroutine:: set_cache_lam_max(cache_lam_max, stat)

      Set the maximum wavelength of the grid cache.

      :p real(RD) cache_lam_max [in]: Maximum wavelength (Å).
      :o integer stat [out]: Status code.


   .. f:subroutine:: set_cache_limit(cache_limit, stat)

      Set the maximum memory usage of the grid cache.

      :p integer cache_limit [in]: Maximum memory usage (MB).
      :o integer stat [out]: Status code.


   .. f:subroutine:: interp_intensity(x_vec, mu, lam, I, stat, deriv_vec, order)

      Interpolate the spectroscopic intensity.

      :p real(RD) x_vec(:) [in]: Photospheric parameter values.
      :p real(RD) mu [in]: Cosine of angle of emergence relative to surface normal.
      :p real(RD) lam(:) [in]: Wavelength abscissa (Å).
      :p real(RD) I(:) [out]: Spectroscopic intensity (erg/cm^2/s/Å/sr) in
            bins delineated by lam; length LEN(lam)-1.
      :o integer stat [out]: Status code.
      :o logical deriv_vec(:) [in]: Derivative flags.
      :o integer order [in]: Interpolation order (1 or 3).

			 
   .. f:subroutine:: interp_E_moment(x_vec, k, lam, E, stat, deriv_vec, order)

      Interpolate the spectroscopic intensity E-moment.

      :p real(RD) x_vec(:) [in]: Photospheric parameter values.
      :p integer k [in]: Degree of moment.
      :p real(RD) lam(:) [in]: Wavelength abscissa (Å).
      :p real(RD) E(:) [out]: Spectroscopic intensity E-moment (erg/cm^2/s/Å)
            in bins delineated by lam; length LEN(lam)-1.
      :o integer stat [out]: Status code.
      :o logical deriv_vec(:) [in]: Derivative flags.
      :o integer order [in]: Interpolation order (1 or 3).


   .. f:subroutine:: interp_D_moment(x_vec, l, lam, D, stat, deriv_vec, order)

      Interpolate the spectroscopic intensity D-moment.

      :p real(RD) x_vec(:) [in]: Photospheric parameter values.
      :p integer l [in]: Harmonic degree of moment.
      :p real(RD) lam(:) [in]: Wavelength abscissa (Å).
      :p real(RD) D(:) [out]: Spectroscopic intensity D-moment (erg/cm^2/s/Å)
            in bins delineated by lam; length LEN(lam)-1.
      :o integer stat [out]: Status code.
      :o logical deriv_vec(:) [in]: Derivative flags.
      :o integer order [in]: Interpolation order (1 or 3).


   .. f:subroutine:: interp_flux(x_vec, lam, I, stat, deriv_vec, order)

      Interpolate the spectroscopic flux.

      :p real(RD) x_vec(:) [in]: Photospheric parameter values.
      :p real(RD) lam(:) [in]: Wavelength abscissa (Å).
      :p real(RD) F(:) [out]: Spectroscopic flux (erg/cm^2/s/Å) in
            bins delineated by lam; length LEN(lam)-1.
      :o integer stat [out]: Status code.
      :o logical deriv_vec(:) [in]: Derivative flags.
      :o integer order [in]: Interpolation order (1 or 3).

			 
   .. f:subroutine:: adjust_x_vec(x_vec, dx_vec, x_adj, stat)

      Adjust photospheric parameters in a specified direction, until 
      they fall within a valid part of the grid.

      :p real(RD) x_vec(:) [in]: Photospheric parameter values.
      :p real(RD) dx_vec(:) [in]: Photospheric parameter adjustment direction. 
            The overall scaling is unimportant, but at least one element must be non-zero.
      :p real(RD) x_adj(:) [out]: Adjusted photospheric parameter values.
      :o integer stat [out]: Status code.
