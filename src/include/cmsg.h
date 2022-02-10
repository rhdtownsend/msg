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

typedef void *specgrid_t;

void load_specgrid(const char *specgrid_filename, specgrid_t *specgrid, int *stat);
void unload_specgrid(specgrid_t specgrid);

void inquire_specgrid(specgrid_t specgrid, double *lam_min, double *lam_max, int shape[], int *rank, double axis_min[], double axis_max[]);

void get_axis_label_specgrid(specgrid_t specgrid, int i, char *axis_label);

void interp_intensity_specgrid(specgrid_t specgrid, double vx[], double mu, int n, double lam[], double I[], int *stat, bool vderiv[]);
void interp_d_moment_specgrid(specgrid_t specgrid, double vx[], int l, int n, double lam[], double D[], int *stat, bool vderiv[]);
void interp_flux_specgrid(specgrid_t specgrid, double vx[], int n, double lam[], double F[], int *stat, bool vderiv[]);

// photgrid interface

typedef void *photgrid_t;

void load_photgrid(const char *photgrid_filename, photgrid_t *photgrid, int *stat);
void load_photgrid_from_specgrid(const char *specgrid_filename, const char *passband_filename, photgrid_t *photgrid, int *stat);

void unload_photgrid(photgrid_t photgrid);

void inquire_photgrid(photgrid_t photgrid, int shape[], int *rank, double axis_min[], double axis_max[]);

void get_axis_label_photgrid(photgrid_t photgrid, int i, char *axis_label);

void interp_intensity_photgrid(photgrid_t photgrid, double vx[], double mu, double *I, int *stat, bool vderiv[]);
void interp_d_moment_photgrid(photgrid_t photgrid, double vx[], int l, double *D, int *stat, bool vderiv[]);
void interp_flux_photgrid(photgrid_t photgrid, double vx[], double *F, int *stat, bool vderiv[]);
