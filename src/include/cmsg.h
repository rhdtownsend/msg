// Header  : cmsg
// Purpose : C headers for cmsg
//
// Copyright 2021-2022 Rich Townsend & The MSG Team
//
// This file is part of MSG. MSG is free software: you can redistribute
// it and/or modify it under the terms of the GNU General Public
// License as published by the Free Software Foundation, version 3.
//
// MSG is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
// or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
// License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

#include "stdbool.h"

// specgrid interface

void c_load_specgrid(const char *filename, void **ptr, int *stat);
void c_unload_specgrid(void *ptr);

void c_inquire_specgrid(void *ptr, double *lam_min, double *lam_max, int shape[], int *rank, double axis_min[], double axis_max[]);

void c_get_axis_label_specgrid(void *ptr, int i, char *axis_label);

void c_interp_intensity_specgrid(void *ptr, double vx[], double mu, int n, double lam[], double I[], int *stat, bool vderiv[]);
void c_interp_d_moment_specgrid(void *ptr, double vx[], int l, int n, double lam[], double D[], int *stat, bool vderiv[]);
void c_interp_flux_specgrid(void *ptr, double vx[], int n, double lam[], double F[], int *stat, bool vderiv[]);

// photgrid interface

void c_load_photgrid(const char *filename, void **ptr, int *stat);
void c_load_photgrid_from_specgrid(const char *filename, const char *passbad_filename, void **ptr, int *stat);

void c_unload_photgrid(void *ptr);

void c_inquire_photgrid(void *ptr, int shape[], int *rank, double axis_min[], double axis_max[]);

void c_get_axis_label_photgrid(void *ptr, int i, char *axis_label);

void c_interp_intensity_photgrid(void *ptr, double vx[], double mu, double *I, int *stat, bool vderiv[]);
void c_interp_d_moment_photgrid(void *ptr, double vx[], int l, double *D, int *stat, bool vderiv[]);
void c_interp_flux_photgrid(void *ptr, double vx[], double *F, int *stat, bool vderiv[]);
