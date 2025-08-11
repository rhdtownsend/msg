#cython: language_level=3
#
# Header  : pycmsg
# Purpose : Cython headers for libcmsg
#
# Copyright 2021-2022 Rich Townsend & The MSG Team
#
# This file is part of MSG. MSG is free software: you can redistribute
# it and/or modify it under the terms of the GNU General Public
# License as published by the Free Software Foundation, version 3.
#
# MSG is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
# License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

import numpy as np
cimport numpy

from libc.stdint cimport uintptr_t
from libcpp cimport bool

# C definitions

cdef extern from "cmsg.h":

    # shared

    cdef void get_msg_version(char *version);

    ctypedef enum Stat:
       STAT_OK,
       STAT_INVALID_DIMENSION,
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
       STAT_INVALID_GROUP_REVISION,
       STAT_INVALID_OMP_CONFIG

    # specgrid

    void load_specgrid(const char *specgrid_filename, void **specgrid, Stat *stat)
    void unload_specgrid(void *specgrid)

    void get_specgrid_rank(void *specgrid, int *rank)
    void get_specgrid_lam_min(void *specgrid, double *lam_min)
    void get_specgrid_lam_max(void *specgrid, double *lam_max)
    void get_specgrid_cache_usage(void *specgrid, int *cache_usage)
    void get_specgrid_cache_limit(void *specgrid, int *cache_limit)
    void get_specgrid_cache_lam_min(void *specgrid, double *cache_lam_min)
    void get_specgrid_cache_lam_max(void *specgrid, double *cache_lam_max)
    void get_specgrid_axis_x_min(void *specgrid, int i, double *axis_x_min)
    void get_specgrid_axis_x_max(void *specgrid, int i, double *axis_x_max)
    void get_specgrid_axis_label(void *specgrid, int i, char *axis_label)

    void set_specgrid_cache_limit(void *specgrid, int cache_limit, Stat *stat)
    void set_specgrid_cache_lam_min(void *specgrid, double cache_lam_min, Stat *stat)
    void set_specgrid_cache_lam_max(void *specgrid, double cache_lam_max, Stat *stat)

    void flush_specgrid_cache(void *specgrid)

    void interp_specgrid_intensity(void *specgrid, int n, int r, double x_vec[], double mu,
                                   double z, double lam[], double I[],
                                   Stat *stat, bool deriv_vec[], int *order)
    void interp_specgrid_E_moment(void *specgrid, int n, int r, double x_vec[], int k,
                                  double z, double lam[], double E[],
                                  Stat *stat, bool deriv_vec[], int *order)
    void interp_specgrid_P_moment(void *specgrid, int n, int r, double x_vec[], int l,
                                  double z, double lam[], double P[],
                                  Stat *stat, bool deriv_vec[], int *order)
    void interp_specgrid_irradiance(void *specgrid, int n, int m, int r, double x_vec[], double[] mu, double[] dOmega,
                                    double[] z, double lam[], double F[],
                                    Stat *stat, bool deriv_vec[], int *order)
    void interp_specgrid_flux(void *specgrid, int n, int r, double x_vec[],
                              double z, double lam[], double F[],
                              Stat *stat, bool deriv_vec[], int *order)
    
    void adjust_specgrid_x_vec(void *specgrid, int r, double x_vec[], double dx_vec[],
                               double x_adj[], Stat *stat)

    # photgrid

    void load_photgrid(const char *photgrid_file_name, void **photgrid, Stat *stat)
    void load_photgrid_from_specgrid(const char *specgrid_file_name,
                                     const char *passband_filename, void **photgrid, Stat *stat)
    void unload_photgrid(void *photgrid)

    void get_photgrid_rank(void *photgrid, int *rank)
    void get_photgrid_cache_usage(void *photgrid, int *cache_usage)
    void get_photgrid_cache_limit(void *photgrid, int *cache_limit)
    void get_photgrid_axis_x_min(void *photgrid, int i, double *axis_x_min)
    void get_photgrid_axis_x_max(void *photgrid, int i, double *axis_x_max)
    void get_photgrid_axis_label(void *photgrid, int i, char *axis_label)

    void set_photgrid_cache_limit(void *photgrid, int cache_limit, Stat *stat)

    void flush_photgrid_cache(void *photgrid)

    void interp_photgrid_intensity(void *photgrid, int r, double x_vec[], double mu,
                                   double *I,
                                   Stat *stat, bool deriv_vec[], int *order)
    void interp_photgrid_E_moment(void *photgrid, int r, double x_vec[], int k,
                                  double *E,
                                  Stat *stat, bool deriv_vec[], int *order)
    void interp_photgrid_P_moment(void *photgrid, int r, double x_vec[], int l,
                                  double *P,
                                  Stat *stat, bool deriv_vec[], int *order)
    void interp_photgrid_irradiance(void *photgrid, int m, int r, double x_vec[], double[] mu, double[] dOmega,
                                    double *F,
                                    Stat *stat, bool deriv_vec[], int *order)
    void interp_photgrid_flux(void *photgrid, int r, double x_vec[],
                              double *F,
                              Stat *stat, bool deriv_vec[], int *order)

    void adjust_photgrid_x_vec(void *photgrid, int r, double x_vec[], double dx_vec[],
                               double x_adj[], Stat *stat)
