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

  double lam[N_LAM];
  double lam_c[N_LAM-1];
  double F[N_LAM-1];
  double F_U;
  double F_B;
  double F_V;
  double R2_d2;
  double U;
  double B;
  double V;

  FILE *fptr;

  // Load the specgrid

  load_specgrid("sg-demo.h5", &specgrid, NULL);

  // Set atmospheric parameters to correspond to Sirius

  for(int i=0; i < 2; i++) {

    get_specgrid_axis_label(specgrid, i, label);

    if (strcmp(label, "logg") == 0) {
      x_vec[i] = 4.277;
    }
    else if (strcmp(label, "logT") == 0) {
      x_vec[i] = 3.996;
    }
    else {
      printf("invalid label\n");
      exit(1);
    }
      
  }

  // Set up the wavelength abscissa

  for(int i=0; i < N_LAM; i++) {
    lam[i] = (LAM_MIN*(N_LAM-1-i) + LAM_MAX*i)/(N_LAM-1);
  }

  for(int i=0; i < N_LAM-1; i++) {
    lam_c[i] = 0.5*(lam[i] + lam[i+1]);
  }

  // Evaluate the flux

  interp_specgrid_flux(specgrid, x_vec, N_LAM, lam, F, NULL, NULL);

  // Write it to a file

  fptr = fopen("spectrum.dat", "w");

  for(int i=0; i < N_LAM-1; i++) {
    fprintf(fptr, "%.17e %.17e\n", lam_c[i], F[i]);
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

  // Evaluate apparent magnitudes (the dilution factor R2_d2 is
  // R^2/d^2, where R is Sirius A's radius and d its distance)

  R2_d2 = 2.1366E-16;

  U = -2.5*log10(F_U*R2_d2);
  B = -2.5*log10(F_B*R2_d2);
  V = -2.5*log10(F_V*R2_d2);

  printf("  V=  %.17e\n", V);
  printf("U-B=  %.17e\n", U-V);
  printf("B-V=  %.17e\n", B-V);

  // Clean up

  unload_specgrid(specgrid);

  unload_photgrid(photgrid_U);
  unload_photgrid(photgrid_B);
  unload_photgrid(photgrid_V);

  // Finish

  exit(0);

}
