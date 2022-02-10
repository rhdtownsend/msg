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

typedef void *specgrid;

void c_load_specgrid(const char *filename, specgrid *grid, int *stat);
void c_unload_specgrid(specgrid *grid);

void c_inquire_specgrid(specgrid grid, double *lam_min, double *lam_max, int shape[], int *rank, double axis_min[], double axis_max[]);

void c_get_axis_label_specgrid(specgrid grid, int i, char *axis_label);

void c_interp_intensity_specgrid(specgrid grid, double vx[], double mu, int n, double lam[], double I[], int *stat, bool vderiv[]);
void c_interp_d_moment_specgrid(specgrid grid, double vx[], int l, int n, double lam[], double D[], int *stat, bool vderiv[]);
void c_interp_flux_specgrid(specgrid grid, double vx[], int n, double lam[], double F[], int *stat, bool vderiv[]);

// photgrid interface

typedef void *photgrid;

void c_load_photgrid(const char *filename, photgrid *grid, int *stat);
void c_load_photgrid_from_specgrid(const char *filename, const char *passband_filename, photgrid *grid, int *stat);

void c_unload_photgrid(photgrid grid);

void c_inquire_photgrid(photgrid grid, int shape[], int *rank, double axis_min[], double axis_max[]);

void c_get_axis_label_photgrid(photgrid grid, int i, char *axis_label);

void c_interp_intensity_photgrid(photgrid grid, double vx[], double mu, double *I, int *stat, bool vderiv[]);
void c_interp_d_moment_photgrid(photgrid grid, double vx[], int l, double *D, int *stat, bool vderiv[]);
void c_interp_flux_photgrid(photgrid grid, double vx[], double *F, int *stat, bool vderiv[]);
