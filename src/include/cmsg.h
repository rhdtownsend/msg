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

void load_specgrid(const char *specgrid_file_name, SpecGrid *specgrid, int *stat);
void unload_specgrid(SpecGrid specgrid);

void get_specgrid_rank(SpecGrid specgrid, int *rank);
void get_specgrid_cache_count(SpecGrid specgrid, int *cache_count);
void get_specgrid_cache_limit(SpecGrid specgrid, int *cache_limit);
void get_specgrid_cache_lam_min(SpecGrid specgrid, double *cache_lam_min);
void get_specgrid_cache_lam_max(SpecGrid specgrid, double *cache_lam_max);
void get_specgrid_axis_x_min(SpecGrid specgrid, int i, double *axis_x_min);
void get_specgrid_axis_x_max(SpecGrid specgrid, int i, double *axis_x_max);
void get_specgrid_axis_label(SpecGrid specgrid, int i, char *axis_label);

void set_specgrid_cache_limit(SpecGrid specgrid, int *cache_limit, int *stat);
void set_specgrid_cache_lam_min(SpecGrid specgrid, double *cache_lam_min, int *stat);
void set_specgrid_cache_lam_max(SpecGrid specgrid, double *cache_lam_max, int *stat);

void interp_specgrid_intensity(SpecGrid specgrid, double x_vec[], double mu, int n, double lam[], double I[], int *stat, bool deriv_vec[]);
void interp_specgrid_e_moment(SpecGrid specgrid, double x_vec[], int k, int n, double lam[], double E[], int *stat, bool deriv_vec[]);
void interp_specgrid_d_moment(SpecGrid specgrid, double x_vec[], int l, int n, double lam[], double D[], int *stat, bool deriv_vec[]);
void interp_specgrid_flux(SpecGrid specgrid, double x_vec[], int n, double lam[], double F[], int *stat, bool deriv_vec[]);

// photgrid interface

typedef void *PhotGrid;

void load_photgrid(const char *photgrid_file_name, PhotGrid *photgrid, int *stat);
void load_photgrid_from_specgrid(const char *specgrid_file_name, const char *passband_filename, PhotGrid *photgrid, int *stat);
void unload_photgrid(PhotGrid photgrid);

void get_photgrid_rank(PhotGrid photgrid, int *rank);
void get_photgrid_cache_count(PhotGrid photgrid, int *cache_count);
void get_photgrid_cache_limit(PhotGrid photgrid, int *cache_limit);
void get_photgrid_axis_x_min(PhotGrid photgrid, int i, double *axis_x_min);
void get_photgrid_axis_x_max(PhotGrid photgrid, int i, double *axis_x_max);
void get_photgrid_axis_label(PhotGrid photgrid, int i, char *axis_label);

void set_photgrid_cache_limit(PhotGrid photgrid, int *cache_limit, int *stat);

void interp_photgrid_intensity(PhotGrid photgrid, double x_vec[], double mu, double *I, int *stat, bool deriv_vec[]);
void interp_photgrid_e_moment(PhotGrid photgrid, double x_vec[], int k, double *E, int *stat, bool deriv_vec[]);
void interp_photgrid_d_moment(PhotGrid photgrid, double x_vec[], int l, double *D, int *stat, bool deriv_vec[]);
void interp_photgrid_flux(PhotGrid photgrid, double x_vec[], double *F, int *stat, bool deriv_vec[]);

// enums etc

enum {
  STAT_OK,
  STAT_OUT_OF_BOUNDS_RANGE_LO,
  STAT_OUT_OF_BOUNDS_RANGE_HI,
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
