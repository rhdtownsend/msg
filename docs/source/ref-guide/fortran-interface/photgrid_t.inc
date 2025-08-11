.. f:type:: photgrid_t

   The photgrid_t type represents a grid of photometric data.

   This grid may be used to interpolate the intensity (or related
   quantities) for a set of photospheric parameter values.


   .. f:subroutine:: get_rank(rank)

      Get the rank (dimension) of the grid.

      :p integer rank [out]: Returned rank.


   .. f:subroutine:: get_shape(shape)

      Get the shape of the grid.

      :p integer shape(:) [out]: Shape; length `rank`.


   .. f:subroutine:: get_axis(i, axis)

      Get an axis of the grid.

      :p integer i [in]: Index of axis (between 1 and `rank`)
      :p axis_t axis [out]: Returned axis.


   .. f:subroutine:: get_cache_limit(cache_limit)

      Get the maximum memory usage of the cache.

      :p integer cache_limit [out]: Maximum memory usage (MB).


   .. f:subroutine:: get_cache_usage(cache_usage)

      Get the current memory usage of the cache.

      :p integer cache_usage [out]: Current memory usage (MB)

      
   .. f:subroutine:: set_cache_limit(cache_limit, stat)

      Set the maximum memory usage of the cache.

      :p integer cache_limit [in]: Maximum memory usage (MB).
      :o integer stat [out]: Status code.


   .. f:subroutine:: interp_intensity(x_vec, mu, I, stat, deriv_vec, order)

      Interpolate the photometric specific intensity for a
      photospheric element, normalized by the zero-point flux.

      :p real(RD) x_vec(:) [in]: Photospheric parameter values.
      :p real(RD) mu [in]: Cosine of angle of emergence relative to element normal.
      :p real(RD) I [out]: Photometric specific intensity (/sr).
      :o integer stat [out]: Status code.
      :o logical deriv_vec(:) [in]: Derivative flags; length SIZE(x_vec).
      :o integer order [in]: Interpolation order (1 or 3).

			 
   .. f:subroutine:: interp_E_moment(x_vec, k, E, stat, deriv_vec, order)

      Interpolate the photometric E-moment for a photospheric element,
      normalized by the zero-point flux.

      :p real(RD) x_vec(:) [in]: Photospheric parameter values.
      :p integer k [in]: Degree of of moment.
      :p real(RD) E [out]: Photometric E-moment (dimensionless).
      :o integer stat [out]: Status code.
      :o logical deriv_vec(:) [in]: Derivative flags; length SIZE(x_vec).
      :o integer order [in]: Interpolation order (1 or 3).


   .. f:subroutine:: interp_P_moment(x_vec, l, P, stat, deriv_vec, order)

      Interpolate the photometric P-moment for a photospheric element,
      normalized by the zero-point flux.

      :p real(RD) x_vec(:) [in]: Photospheric parameter values.
      :p integer l [in]: Harmonic degree of moment.
      :p real(RD) P [out]: Photometric P-moment (dimensionless).
      :o integer stat [out]: Status code.
      :o logical deriv_vec(:) [in]: Derivative flags; length SIZE(x_vec).
      :o integer order [in]: Interpolation order (1 or 3).


   .. f:subroutine:: interp_irradiance(x_vec, mu, dOmega, F, stat, deriv_vec, order)

      Interpolate the photometric irradiance for an object composed of
      multiple photospheric elements, normalized by the zero-point
      flux.

      :p real(RD) x_vec(:,:) [in]: Photospheric parameter values.
      :p real(RD) mu(:) [in]: Cosines of angles of emergence relative to element
            normals; length SIZE(x_vec, 2).
      :p real(RD) dOmega(:) [in]: Solid angles (sr) of elements; length SIZE(x_vec, 2).
      :p real(RD) F [out]: Photometric irradiance (dimensionless).
      :o integer stat [out]: Status code.
      :o logical deriv_vec(:) [in]: Derivative flags; length SIZE(x_vec).
      :o integer order [in]: Interpolation order (1 or 3).


   .. f:subroutine:: interp_flux(x_vec, F, stat, deriv_vec, order)

      Interpolate the photometric flux for a photospheric element,
      normalized by the zero-point flux.

      :p real(RD) x_vec(:) [in]: Photospheric parameter values.
      :p real(RD) F [out]: Photometric flux (dimensionless)
      :o integer stat [out]: Status code.
      :o logical deriv_vec(:) [in]: Derivative flags; length SIZE(x_vec).
      :o integer order [in]: Interpolation order (1 or 3).


   .. f:subroutine:: adjust_x_vec(x_vec, dx_vec, x_adj, stat)

      Adjust photospheric parameters in a specified direction, until 
      they fall within a valid part of the grid.

      :p real(RD) x_vec(:) [in]: Photospheric parameter values.
      :p real(RD) dx_vec(:) [in]: Photospheric parameter adjustment direction. 
            The overall scaling is unimportant, but at least one element must be non-zero.
	    Length SIZE(x_vec).
      :p real(RD) x_adj(:) [out]: Adjusted photospheric parameter values;
	    length SIZE(x_vec).
      :o integer stat [out]: Status code.
