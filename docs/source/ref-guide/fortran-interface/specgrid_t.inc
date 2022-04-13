.. _fortran-specgrid:

.. f:currentmodule:: msg_m

.. f:type:: specgrid_t

The specgrid_t type represents a grid of spectroscopic intensity data.

   This grid may be used to interpolate the intensity (or related
   quantities) across a wavelength abscissa and for a set of
   atmospheric parameter values.


   .. f:subroutine:: get_rank(rank)

      Get the rank (dimension) of the grid.

      :o integer rank: Returned rank.


   .. f:subroutine:: get_lam_min(lam_min)

      Get the minimum wavelength of the grid.

      :o real(RD) lam_min [out]: Returned minimum wavelength.


   .. f:subroutine:: get_lam_max(lam_max)

      Get the maximum wavelength of the grid.

      :o real(RD) lam_max [out]: Returned maximum wavelength.


   .. f:subroutine:: get_cache_lam_min(cache_lam_min)

      Get the minimum wavelength of the grid cache.

      :o real(RD) lam_min [out]: Returned minimum wavelength.


   .. f:subroutine:: get_cache_lam_max(cache_lam_max)

      Get the maximum wavelength of the grid cache.

      :o real(RD) cacheLlam_max [out]: Returned maximum wavelength.


   .. f:subroutine:: get_cache_count(cache_count)

      Get the number of nodes currently held in the grid cache.

      :o integer cache_count: Returned number of nodes.

      
   .. f:subroutine:: get_cache_count(cache_count)

      Get the number of nodes currently held in the grid cache.

      :o integer cache_count: Returned number of nodes.



Wavelength abscissa minimum.
      :o real(RD) lam_max [out]: Wavelength abscissa maximum.
      :o integer shape(:) [out]: Atmospheric parameter axes lengths.
      :o integer rank [out]: Number of atmospheric parameters.
      :o integer axis_min(:) [out]: Atmospheric parameter axis minima.
      :o integer axis_max(:) [out]: Atmospheric parameter axis maxima.
      :o character(*) axis_labels(:) [out]: Atmospheric parameter axis labels.
				   
   
   .. f:subroutine:: interp_intensity(vx, mu, lam, I, stat, vderiv)

      Interpolate the spectroscopic intensity.

      :p real(RD) vx(:) [in]: Atmospheric parameter values.
      :p real(RD) mu [in]: Cosine of angle of emergence relative to surface normal.
      :p real(RD) lam(:) [in]: Wavelength abscissa (Å).
      :p real(RD) I(:) [out]: Spectroscopic intensity (erg/cm^2/s/Å/sr) in
            bins delineated by lam; length LEN(lam)-1.
      :o integer(RD) stat [out]: Status code.
      :o logical vderiv(:) [in]: Derivative flags.

			 
   .. f:subroutine:: interp_E_moment(vx, k, lam, E, stat, vderiv)

      Interpolate the spectroscopic intensity E-moment.

      :p real(RD) vx(:) [in]: Atmospheric parameter values.
      :p integer k [in]: Degree of moment.
      :p real(RD) lam(:) [in]: Wavelength abscissa (Å).
      :p real(RD) E(:) [out]: Spectroscopic intensity E-moment (erg/cm^2/s/Å)
            in bins delineated by lam; length LEN(lam)-1.
      :o integer(RD) stat [out]: Status code.
      :o logical vderiv(:) [in]: Derivative flags.


   .. f:subroutine:: interp_D_moment(vx, l, lam, D, stat, vderiv)

      Interpolate the spectroscopic intensity D-moment.

      :p real(RD) vx(:) [in]: Atmospheric parameter values.
      :p integer l [in]: Harmonic degree of moment.
      :p real(RD) lam(:) [in]: Wavelength abscissa (Å).
      :p real(RD) D(:) [out]: Spectroscopic intensity D-moment (erg/cm^2/s/Å)
            in bins delineated by lam; length LEN(lam)-1.
      :o integer(RD) stat [out]: Status code.
      :o logical vderiv(:) [in]: Derivative flags.


   .. f:subroutine:: interp_flux(vx, lam, I, stat, vderiv)

      Interpolate the spectroscopic flux.

      :p real(RD) vx(:) [in]: Atmospheric parameter values.
      :p real(RD) lam(:) [in]: Wavelength abscissa (Å).
      :p real(RD) F(:) [out]: Spectroscopic flux (erg/cm^2/s/Å) in
            bins delineated by lam; length LEN(lam)-1.
      :o integer(RD) stat [out]: Status code.
      :o logical vderiv(:) [in]: Derivative flags.

			 
