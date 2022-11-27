program fortran_walkthrough

   ! Uses

   use forum_m
   use fmsg_m

   ! No implicit typing

   implicit none

   ! Parameters

   real(RD), parameter :: lam_min = 3000._RD
   real(RD), parameter :: lam_max = 7000._RD
   integer, parameter  :: n_lam = 501

   ! Variables

   type(specgrid_t)     :: specgrid
   type(axis_t)         :: axis
   character(LABEL_LEN) :: label
   integer              :: i
   real(RD)             :: lam(n_lam)
   real(RD)             :: lam_c(n_lam-1)
   real(RD)             :: x_vec(2)
   real(RD)             :: F_lam(n_lam-1)
   integer              :: unit
   type(photgrid_t)     :: photgrid_U
   type(photgrid_t)     :: photgrid_B
   type(photgrid_t)     :: photgrid_V
   real(RD)             :: F_U
   real(RD)             :: F_B
   real(RD)             :: F_V
   real(RD)             :: R2_d2
   real(RD)             :: U
   real(RD)             :: B
   real(RD)             :: V

   ! Load the specgrid

   call load_specgrid('sg-demo.h5', specgrid)

   ! Set atmospheric parameters to correspond to Sirius A

   do i = 1, 2

      call specgrid%get_axis(i, axis)
      call axis%get_label(label)

      select case(label)
      case('log(g)')
         x_vec(i) = 4.277_RD
      case('Teff')
         x_vec(i) = 9906._RD
      case default
         stop 'unrecognized axis label'
      end select

   end do
   
   ! Set up the wavelength abscissa

   lam = [((lam_min*(n_lam-i) + lam_max*(i-1))/(n_lam-1), i=1,n_lam)]

   lam_c = 0.5_RD*(lam(:n_lam-1) + lam(2:))

   ! Evaluate the flux

   call specgrid%interp_flux(x_vec, lam, F_lam)

   ! Write it to a file

   open(NEWUNIT=unit, FILE='spectrum.dat', STATUS='REPLACE')

   do i = 1, n_lam-1
      write(unit, *) lam_c(i), F_lam(i)
   end do

   close(unit)

   ! Load the photgrids

   call load_photgrid_from_specgrid('sg-demo.h5', 'pb-Generic-Johnson.U-Vega.h5', photgrid_U)
   call load_photgrid_from_specgrid('sg-demo.h5', 'pb-Generic-Johnson.B-Vega.h5', photgrid_B)
   call load_photgrid_from_specgrid('sg-demo.h5', 'pb-Generic-Johnson.V-Vega.h5', photgrid_V)

   ! Evaluate fluxes

   call photgrid_U%interp_flux(x_vec, F_U)
   call photgrid_B%interp_flux(x_vec, F_B)
   call photgrid_V%interp_flux(x_vec, F_V)

   ! Evaluate apparent magnitudes (the droid factor R2_d2 is
   ! R**2/d**2, where R is Sirius A's radius and d its distance)

   R2_d2 = 2.1366E-16_RD

   U = -2.5_RD*LOG10(F_U*R2_d2)
   B = -2.5_RD*LOG10(F_B*R2_d2)
   V = -2.5_RD*LOG10(F_V*R2_d2)

   print *, '  V=', V
   print *, 'U-B=', U-B
   print *, 'B-V=', B-V

   ! Finish

end program fortran_walkthrough
