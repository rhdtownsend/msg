program fortran_walkthrough

   ! Uses

   use forum_m
   use fmsg_m

   ! No implicit typing

   implicit none

   ! Parameters

   real(RD), parameter :: lam_min = 3800._RD
   real(RD), parameter :: lam_max = 7000._RD
   integer, parameter  :: n_lam = 501

   ! Variables

   type(specgrid_t)     :: specgrid
   type(axis_t)         :: axis
   character(LABEL_LEN) :: label
   integer              :: i
   real(RD)             :: z
   real(RD)             :: R2_d2
   real(RD)             :: lam(n_lam)
   real(RD)             :: lam_c(n_lam-1)
   real(RD)             :: x_vec(2)
   real(RD)             :: F(n_lam-1)
   real(RD)             :: F_obs(n_lam-1)
   integer              :: unit
   type(photgrid_t)     :: photgrid_U
   type(photgrid_t)     :: photgrid_B
   type(photgrid_t)     :: photgrid_V
   real(RD)             :: F_U
   real(RD)             :: F_B
   real(RD)             :: F_V
   real(RD)             :: F_U_obs
   real(RD)             :: F_B_obs
   real(RD)             :: F_V_obs
   real(RD)             :: U
   real(RD)             :: B
   real(RD)             :: V

   ! Create the specgrid_t object

   call load_specgrid('sg-demo.h5', specgrid)

   ! Set photospheric parameters to correspond to Sirius A

   do i = 1, 2

      call specgrid%get_axis(i, axis)
      call axis%get_label(label)

      select case(label)
      case('log(g)')
         x_vec(i) = 4.2774_RD
      case('Teff')
         x_vec(i) = 9909.2_RD
      case default
         stop 'unrecognized axis label'
      end select

   end do

   ! Set the redshift

   z = -1.83E-5_RD
   
   ! Set the dilution factor R2_d2 = R**2/d**2, where R is Sirius A's
   ! radius and d its distance

   R2_d2 = 2.1351E-16_RD

   ! Set up the wavelength abscissa

   lam = [((lam_min*(n_lam-i) + lam_max*(i-1))/(n_lam-1), i=1,n_lam)]
   lam_c = 0.5_RD*(lam(:n_lam-1) + lam(2:))

   ! Evaluate the irradiance

   call specgrid%interp_flux(x_vec, z, lam, F)

   F_obs = R2_d2*F

   ! Write it to a file

   open(NEWUNIT=unit, FILE='spectrum.dat', STATUS='REPLACE')

   do i = 1, n_lam-1
      write(unit, *) lam_c(i), F_obs(i)
   end do

   close(unit)

   ! Load the photgrid_t objects

   call load_photgrid_from_specgrid('sg-demo.h5', 'pb-Generic-Johnson.U-Vega.h5', photgrid_U)
   call load_photgrid_from_specgrid('sg-demo.h5', 'pb-Generic-Johnson.B-Vega.h5', photgrid_B)
   call load_photgrid_from_specgrid('sg-demo.h5', 'pb-Generic-Johnson.V-Vega.h5', photgrid_V)

   ! Evaluate photometric irradiances

   call photgrid_U%interp_flux(x_vec, F_U)
   call photgrid_B%interp_flux(x_vec, F_B)
   call photgrid_V%interp_flux(x_vec, F_V)

   F_U_obs = R2_d2*F_U
   F_B_obs = R2_d2*F_B
   F_V_obs = R2_d2*F_V

   ! Evaluate apparent magnitudes

   U = -2.5_RD*LOG10(F_U_obs)
   B = -2.5_RD*LOG10(F_B_obs)
   V = -2.5_RD*LOG10(F_V_obs)

   print 100, '  V=  ', V
   print 100, 'U-B=  ', U-B
   print 100, 'B-V=  ', B-V
100 format(A, 1pe24.17)

   ! Finish

end program fortran_walkthrough
