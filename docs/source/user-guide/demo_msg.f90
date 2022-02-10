program demo_msg

   ! Uses

   use forum_m
   use fmsg_m

   ! No implicit typing

   implicit none

   ! Parameters

   real(RD), parameter :: lam_min = 3000._RD
   real(RD), parameter :: lam_max = 7000._RD
   integer, parameter  :: n_lam = 501
   real(RD), parameter :: Teff = 9940._RD
   real(RD), parameter :: logg = 4.33_RD

   ! Variables

   type(specgrid_t) :: specgrid
   integer          :: i
   real(RD)         :: lam(n_lam)
   real(RD)         :: lam_c(n_lam-1)
   real(RD)         :: vx(2)
   real(RD)         :: F_lam(n_lam-1)
   integer          :: stat

   ! Load the specgrid

   call load_specgrid('sg-demo.h5', specgrid)

   ! Set atmosphere parameters (alphabetical!)

   vx(1) = logg        ! logg
   vx(2) = LOG10(Teff) ! logT

   ! Set up the wavelength abscissa

   lam = [((lam_min*(n_lam-i) + lam_max*(i-1))/(n_lam-1), i=1,n_lam)]

   lam_c = 0.5_RD*(lam(:n_lam-1) + lam(2:))

   ! Evaluate the flux

   call specgrid%interp_flux(vx, lam, F_lam, stat)
   if (stat /= STAT_OK) then
      stop
   end if

   ! Print it out

   do i = 1, n_lam-1
      print *, lam_c(i), F_lam(i)
   end do

end program demo_msg
