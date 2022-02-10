.. _fortran-photgrid:

.. f:currentmodule:: msg_m

.. f:type:: photgrid_t

   The photgrid_t type represents a grid of photometric intensity data.

   This grid may be used to interpolate the intensity (or related
   quantities) for a set of atmospheric parameter values.


   .. f:subroutine:: inquire(shape, rank, axis_min, axis_max, axis_labels)

      Inquire about grid properties.

      :o integer shape(:) [out]: Atmospheric parameter axes lengths.
      :o integer rank [out]: Number of atmospheric parameters.
      :o integer axis_min(:) [out]: Atmospheric parameter axis minima.
      :o integer axis_max(:) [out]: Atmospheric parameter axis maxima.
      :o character(*) axis_labels(:) [out]: Atmospheric parameter axis labels.
				   
   
   .. f:subroutine:: interp_intensity(vx, mu, I, stat, vderiv)

      Interpolate the photometric intensity.

      :p real(RD) vx(:) [in]: Atmospheric parameter values.
      :p real(RD) mu [in]: Cosine of angle of emergence relative to 
	 surface normal.
      :p real(RD) I [out]: Photometric intensity (erg/cm^2/s/sr).
      :o integer(RD) stat [out]: Status code.
      :o logical vderiv(:) [in]: Derivative flags.

			 
   .. f:subroutine:: interp_D_moment(vx, l, D, stat, vderiv)

      Interpolate the photometric intensity moment.

      :p real(RD) vx(:) [in]: Atmospheric parameter values.
      :p integer l [in]: Harmonic degree of moment.
      :p real(RD) D [out]: Photometric intensity moment (erg/cm^2/s).
      :o integer(RD) stat [out]: Status code.
      :o logical vderiv(:) [in]: Derivative flags.


   .. f:subroutine:: interp_flux(vx, F, stat, vderiv)

      Interpolate the photometric flux.

      :p real(RD) vx(:) [in]: Atmospheric parameter values.
      :p real(RD) F [out]: Photometric flux (erg/cm^2/s).
      :o integer(RD) stat [out]: Status code.
      :o logical vderiv(:) [in]: Derivative flags.
