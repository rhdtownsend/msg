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

typedef void *SpecGrid;

void load_SpecGrid(const char *specgrid_filename, SpecGrid *specgrid, int *stat, int *cache_limit);
void unload_SpecGrid(SpecGrid specgrid);

void inquire_SpecGrid(SpecGrid specgrid, double *lam_min, double *lam_max, int shape[], int *rank, double axis_min[], double axis_max[]);

void get_axis_label_SpecGrid(SpecGrid specgrid, int i, char *axis_label);

void interp_intensity_SpecGrid(SpecGrid specgrid, double vx[], double mu, int n, double lam[], double I[], int *stat, bool vderiv[]);
void interp_E_moment_SpecGrid(SpecGrid specgrid, double vx[], int k, int n, double lam[], double E[], int *stat, bool vderiv[]);
void interp_D_moment_SpecGrid(SpecGrid specgrid, double vx[], int l, int n, double lam[], double D[], int *stat, bool vderiv[]);
void interp_flux_SpecGrid(SpecGrid specgrid, double vx[], int n, double lam[], double F[], int *stat, bool vderiv[]);

// photgrid interface

typedef void *PhotGrid;

void load_PhotGrid(const char *photgrid_filename, PhotGrid *photgrid, int *stat);
void load_PhotGrid_from_SpecGrid(const char *specgrid_filename, const char *passband_filename, PhotGrid *photgrid, int *stat);

void unload_PhotGrid(PhotGrid photgrid);

void inquire_PhotGrid(PhotGrid photgrid, int shape[], int *rank, double axis_min[], double axis_max[]);

void get_axis_label_PhotGrid(PhotGrid photgrid, int i, char *axis_label);

void interp_intensity_PhotGrid(PhotGrid photgrid, double vx[], double mu, double *I, int *stat, bool vderiv[]);
void interp_E_moment_PhotGrid(PhotGrid photgrid, double vx[], int k, double *E, int *stat, bool vderiv[]);
void interp_D_moment_PhotGrid(PhotGrid photgrid, double vx[], int l, double *D, int *stat, bool vderiv[]);
void interp_flux_PhotGrid(PhotGrid photgrid, double vx[], double *F, int *stat, bool vderiv[]);

// enums etc

enum {
  STAT_OK,
  STAT_OUT_OF_BOUNDS_AXIS_LO,
  STAT_OUT_OF_BOUNDS_AXIS_HI,
  STAT_OUT_OF_BOUNDS_LAM_LO,
  STAT_OUT_OF_BOUNDS_LAM_HI,
  STAT_OUT_OF_BOUNDS_MU_LO,
  STAT_OUT_OF_BOUNDS_MU_HI,
  STAT_UNAVAILABLE_DATA,
  STAT_INVALID_ARGUMENT,
  STAT_INVALID_TYPE,
  STAT_FILE_NOT_FOUND
};
