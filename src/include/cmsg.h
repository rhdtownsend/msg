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

// Workaround for later versions of numpy defining I

#if defined(I)
  #undef I
#endif

// enums etc

typedef enum {
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
  STAT_FILE_NOT_FOUND,
  STAT_INVALID_FILE_TYPE,
  STAT_INVALID_GROUP_TYPE,
  STAT_INVALID_GROUP_REVISION
} Stat;

// specgrid interface

typedef void *SpecGrid;

void load_specgrid(const char *specgrid_file_name, SpecGrid *specgrid, Stat *stat);
void unload_specgrid(SpecGrid specgrid);

void get_specgrid_rank(SpecGrid specgrid, int *rank);
void get_specgrid_shape(SpecGrid specgrid, int shape[]);
void get_specgrid_lam_min(SpecGrid specgrid, double *lam_min);
void get_specgrid_lam_max(SpecGrid specgrid, double *lam_max);
void get_specgrid_cache_lam_min(SpecGrid specgrid, double *cache_lam_min);
void get_specgrid_cache_lam_max(SpecGrid specgrid, double *cache_lam_max);
void get_specgrid_cache_limit(SpecGrid specgrid, int *cache_limit);
void get_specgrid_cache_usage(SpecGrid specgrid, int *cache_usage);
void get_specgrid_axis_x_min(SpecGrid specgrid, int i, double *axis_x_min);
void get_specgrid_axis_x_max(SpecGrid specgrid, int i, double *axis_x_max);
void get_specgrid_axis_label(SpecGrid specgrid, int i, char *axis_label);

void set_specgrid_cache_lam_min(SpecGrid specgrid, double cache_lam_min, Stat *stat);
void set_specgrid_cache_lam_max(SpecGrid specgrid, double cache_lam_max, Stat *stat);
void set_specgrid_cache_limit(SpecGrid specgrid, int cache_limit, Stat *stat);

void flush_specgrid_cache(SpecGrid specgrid);

void interp_specgrid_intensity(SpecGrid specgrid, double x_vec[], double mu, int n, double lam[], double I[], Stat *stat, bool deriv_vec[], int *order);
void interp_specgrid_E_moment(SpecGrid specgrid, double x_vec[], int k, int n, double lam[], double E[], Stat *stat, bool deriv_vec[], int *order);
void interp_specgrid_D_moment(SpecGrid specgrid, double x_vec[], int l, int n, double lam[], double D[], Stat *stat, bool deriv_vec[], int *order);
void interp_specgrid_flux(SpecGrid specgrid, double x_vec[], int n, double lam[], double F[], Stat *stat, bool deriv_vec[], int *order);

void adjust_specgrid_x_vec(SpecGrid specgrid, double x_vec[], double dx_vec[], double x_adj[], Stat *stat);

// photgrid interface

typedef void *PhotGrid;

void load_photgrid(const char *photgrid_file_name, PhotGrid *photgrid, Stat *stat);
void load_photgrid_from_specgrid(const char *specgrid_file_name, const char *passband_filename, PhotGrid *photgrid, Stat *stat);
void unload_photgrid(PhotGrid photgrid);

void get_photgrid_rank(PhotGrid photgrid, int *rank);
void get_photgrid_shape(PhotGrid photgrid, int shape[]);
void get_photgrid_cache_limit(PhotGrid photgrid, int *cache_limit);
void get_photgrid_cache_usage(PhotGrid photgrid, int *cache_usage);
void get_photgrid_axis_x_min(PhotGrid photgrid, int i, double *axis_x_min);
void get_photgrid_axis_x_max(PhotGrid photgrid, int i, double *axis_x_max);
void get_photgrid_axis_label(PhotGrid photgrid, int i, char *axis_label);

void set_photgrid_cache_limit(PhotGrid photgrid, int cache_limit, Stat *stat);

void flush_photgrid_cache(PhotGrid photgrid);

void interp_photgrid_intensity(PhotGrid photgrid, double x_vec[], double mu, double *I, Stat *stat, bool deriv_vec[], int *order);
void interp_photgrid_E_moment(PhotGrid photgrid, double x_vec[], int k, double *E, Stat *stat, bool deriv_vec[], int *order);
void interp_photgrid_D_moment(PhotGrid photgrid, double x_vec[], int l, double *D, Stat *stat, bool deriv_vec[], int *order);
void interp_photgrid_flux(PhotGrid photgrid, double x_vec[], double *F, Stat *stat, bool deriv_vec[], int *order);

void adjust_photgrid_x_vec(PhotGrid photgrid, double x_vec[], double dx_vec[], double x_adj[], Stat *stat);

// library routines

void get_msg_version(char *version);
