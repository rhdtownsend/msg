#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>

#include "cmsg.h"

#define N_LAM 501
#define LAM_MIN 3000.
#define LAM_MAX 7000.

int main(int argc, char *argv[]) {

  SpecGrid specgrid;
  PhotGrid photgrid_U;
  PhotGrid photgrid_B;
  PhotGrid photgrid_V;
  
  char label[17];

  double x_vec[2];

  double R2_d2;

  double lam[N_LAM];
  double lam_c[N_LAM-1];
  double F[N_LAM-1];
  double F_obs[N_LAM-1];
  double F_U;
  double F_B;
  double F_V;
  double F_U_obs;
  double F_B_obs;
  double F_V_obs;
  double U;
  double B;
  double V;

  FILE *fptr;

  // Load the specgrid

  load_specgrid("sg-demo.h5", &specgrid, NULL);

  // Set photospheric parameters to correspond to Sirius A

  for(int i=0; i < 2; i++) {

    get_specgrid_axis_label(specgrid, i, label);

    if (strcmp(label, "log(g)") == 0) {
      x_vec[i] = 4.2774;
    }
    else if (strcmp(label, "Teff") == 0) {
      x_vec[i] = 9909.2;
    }
    else {
      printf("invalid label\n");
      exit(1);
    }
      
  }

  // Set the dilution factor R2_d2 = R**2/d**2, where R is Sirius A's
  // radius and d its distance

  R2_d2 = 2.1351E-16;

  // Set up the wavelength abscissa

  for(int i=0; i < N_LAM; i++) {
    lam[i] = (LAM_MIN*(N_LAM-1-i) + LAM_MAX*i)/(N_LAM-1);
  }

  for(int i=0; i < N_LAM-1; i++) {
    lam_c[i] = 0.5*(lam[i] + lam[i+1]);
  }

  // Evaluate the flux

  interp_specgrid_flux(specgrid, x_vec, N_LAM, lam, F, NULL, NULL);

  for(int i=0; i < N_LAM-1; i++) {
    F_obs[i] = R2_d2*F[i];
  }

  // Write it to a file

  fptr = fopen("spectrum.dat", "w");

  for(int i=0; i < N_LAM-1; i++) {
    fprintf(fptr, "%.17e %.17e\n", lam_c[i], F_obs[i]);
  }

  fclose(fptr);

  // Load the photgrids

  load_photgrid_from_specgrid("sg-demo.h5", "pb-Generic-Johnson.U-Vega.h5", &photgrid_U, NULL);
  load_photgrid_from_specgrid("sg-demo.h5", "pb-Generic-Johnson.B-Vega.h5", &photgrid_B, NULL);
  load_photgrid_from_specgrid("sg-demo.h5", "pb-Generic-Johnson.V-Vega.h5", &photgrid_V, NULL);

  // Evaluate fluxes

  interp_photgrid_flux(photgrid_U, x_vec, &F_U, NULL, NULL);
  interp_photgrid_flux(photgrid_B, x_vec, &F_B, NULL, NULL);
  interp_photgrid_flux(photgrid_V, x_vec, &F_V, NULL, NULL);

  F_U_obs = R2_d2*F_U;
  F_B_obs = R2_d2*F_B;
  F_V_obs = R2_d2*F_V;

  // Evaluate apparent magnitudes

  U = -2.5*log10(F_U_obs);
  B = -2.5*log10(F_B_obs);
  V = -2.5*log10(F_V_obs);

  printf("  V=  %.17e\n", V);
  printf("U-B=  %.17e\n", U-B);
  printf("B-V=  %.17e\n", B-V);

  // Clean up

  unload_specgrid(specgrid);

  unload_photgrid(photgrid_U);
  unload_photgrid(photgrid_B);
  unload_photgrid(photgrid_V);

  // Finish

  exit(0);

}
