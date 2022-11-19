#cython: language_level=3
#
# Module  : pycmsg
# Purpose : Cython wrapper for libcmsg
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

    # specgrid

    void load_specgrid(const char *specgrid_filename, void **specgrid, Stat *stat)
    void unload_specgrid(void *specgrid)

    void get_specgrid_rank(void *specgrid, int *rank)
    void get_specgrid_lam_min(void *specgrid, double *lam_min)
    void get_specgrid_lam_max(void *specgrid, double *lam_max)
    void get_specgrid_cache_usage(void *specgrid, long *cache_usage)
    void get_specgrid_cache_limit(void *specgrid, long *cache_limit)
    void get_specgrid_cache_lam_min(void *specgrid, double *cache_lam_min)
    void get_specgrid_cache_lam_max(void *specgrid, double *cache_lam_max)
    void get_specgrid_axis_x_min(void *specgrid, int i, double *axis_x_min)
    void get_specgrid_axis_x_max(void *specgrid, int i, double *axis_x_max)
    void get_specgrid_axis_label(void *specgrid, int i, char *axis_label)

    void set_specgrid_cache_limit(void *specgrid, long cache_limit, Stat *stat)
    void set_specgrid_cache_lam_min(void *specgrid, double cache_lam_min, Stat *stat)
    void set_specgrid_cache_lam_max(void *specgrid, double cache_lam_max, Stat *stat)

    void interp_specgrid_intensity(void *specgrid, double x_vec[], double mu,
                                   int n, double lam[], double I[], Stat *stat,
                                   bool deriv_vec[])
    void interp_specgrid_E_moment(void *specgrid, double x_vec[], int k, int n,
                                  double lam[], double E[], Stat *stat, bool deriv_vec[])
    void interp_specgrid_D_moment(void *specgrid, double x_vec[], int l, int n,
                                  double lam[], double D[], Stat *stat, bool deriv_vec[])
    void interp_specgrid_flux(void *specgrid, double x_vec[], int n, double lam[],
                              double F[], Stat *stat, bool deriv_vec[])
    
    # photgrid

    void load_photgrid(const char *photgrid_file_name, void **photgrid, Stat *stat)
    void load_photgrid_from_specgrid(const char *specgrid_file_name,
                                     const char *passband_filename, void **photgrid, Stat *stat)
    void unload_photgrid(void *photgrid)

    void get_photgrid_rank(void *photgrid, int *rank)
    void get_photgrid_cache_count(void *photgrid, int *cache_count)
    void get_photgrid_cache_limit(void *photgrid, int *cache_limit)
    void get_photgrid_axis_x_min(void *photgrid, int i, double *axis_x_min)
    void get_photgrid_axis_x_max(void *photgrid, int i, double *axis_x_max)
    void get_photgrid_axis_label(void *photgrid, int i, char *axis_label)

    void set_photgrid_cache_limit(void *photgrid, int cache_limit, Stat *stat)

    void interp_photgrid_intensity(void *photgrid, double x_vec[], double mu,
                                   double *I, Stat *stat, bool deriv_vec[])
    void interp_photgrid_E_moment(void *photgrid, double x_vec[], int k, double *E,
                                  Stat *stat, bool deriv_vec[])
    void interp_photgrid_D_moment(void *photgrid, double x_vec[], int l, double *D,
                                  Stat *stat, bool deriv_vec[])
    void interp_photgrid_flux(void *photgrid, double x_vec[], double *F, Stat *stat,
                              bool deriv_vec[])


# Wrappers

# specgrid

def _load_specgrid(str specgrid_filename):

    cdef void *specgrid
    cdef Stat stat

    load_specgrid(specgrid_filename.encode('ascii'), &specgrid, &stat)
    _handle_error(stat)

    return <uintptr_t>specgrid


def _unload_specgrid(uintptr_t specgrid):

    unload_specgrid(<void *>specgrid)


def _get_specgrid_rank(uintptr_t specgrid):
    
    cdef int rank

    get_specgrid_rank(<void *>specgrid, &rank)

    return rank


def _get_specgrid_lam_min(uintptr_t specgrid):

    cdef double lam_min

    get_specgrid_lam_min(<void *>specgrid, &lam_min)

    return lam_min


def _get_specgrid_lam_max(uintptr_t specgrid):

    cdef double lam_max

    get_specgrid_lam_max(<void *>specgrid, &lam_max)

    return lam_max


def _get_specgrid_cache_usage(uintptr_t specgrid):

    cdef long cache_usage

    get_specgrid_cache_usage(<void *>specgrid, &cache_usage)

    return cache_usage


def _get_specgrid_cache_limit(uintptr_t specgrid):

    cdef long cache_limit
    
    get_specgrid_cache_limit(<void *>specgrid, &cache_limit)

    return cache_limit


def _get_specgrid_cache_lam_min(uintptr_t specgrid):

    cdef double cache_lam_min
    
    get_specgrid_cache_lam_min(<void *>specgrid, &cache_lam_min)

    return cache_lam_min


def _get_specgrid_cache_lam_max(uintptr_t specgrid):

    cdef double cache_lam_max
    
    get_specgrid_cache_lam_max(<void *>specgrid, &cache_lam_max)

    return cache_lam_max


def _get_specgrid_axis_x_min(uintptr_t specgrid, int i):

    cdef double x_min
    
    get_specgrid_axis_x_min(<void *>specgrid, i, &x_min)

    return x_min


def _get_specgrid_axis_x_max(uintptr_t specgrid, int i):

    cdef double x_max
    
    get_specgrid_axis_x_max(<void *>specgrid, i, &x_max)

    return x_max


def _get_specgrid_axis_label(uintptr_t specgrid, int i):

    cdef char label[17]
    
    get_specgrid_axis_label(<void *>specgrid, i, label)

    return label.decode('ascii')


def _set_specgrid_cache_limit(uintptr_t specgrid, long cache_limit):

    cdef Stat stat

    set_specgrid_cache_limit(<void *>specgrid, cache_limit, &stat)
    _handle_error(stat)

    
def _set_specgrid_cache_lam_min(uintptr_t specgrid, double cache_lam_min):

    cdef Stat stat

    set_specgrid_cache_lam_min(<void *>specgrid, cache_lam_min, &stat)
    _handle_error(stat)


def _set_specgrid_cache_lam_max(uintptr_t specgrid, double cache_lam_max):

    cdef Stat stat

    set_specgrid_cache_lam_max(<void *>specgrid, cache_lam_max, &stat)
    _handle_error(stat)


def _interp_specgrid_intensity(uintptr_t specgrid, double[:] x_vec, double mu, double[:] lam, bool[:] deriv_vec):

    cdef double[:] I
    cdef Stat stat

    n = len(lam)

    I = np.empty(n-1, dtype=np.double)

    interp_specgrid_intensity(<void *>specgrid, &x_vec[0], mu, n, &lam[0], &I[0], &stat, &deriv_vec[0])
    _handle_error(stat)

    return I


def _interp_specgrid_E_moment(uintptr_t specgrid, double[:] x_vec, int k, double[:] lam, bool[:] deriv_vec):

    cdef double[:] E
    cdef Stat stat

    n = len(lam)

    E = np.empty(n-1, dtype=np.double)

    interp_specgrid_E_moment(<void *>specgrid, &x_vec[0], k, n, &lam[0], &E[0], &stat, &deriv_vec[0])
    _handle_error(stat)

    return E


def _interp_specgrid_D_moment(uintptr_t specgrid, double[:] x_vec, int l, double[:] lam, bool[:] deriv_vec):

    cdef double[:] D
    cdef Stat stat

    n = len(lam)

    D = np.empty(n-1, dtype=np.double)

    interp_specgrid_D_moment(<void *>specgrid, &x_vec[0], l, n, &lam[0], &D[0], &stat, &deriv_vec[0])
    _handle_error(stat)

    return D


def _interp_specgrid_flux(uintptr_t specgrid, double[:] x_vec, double[:] lam, bool[:] deriv_vec):

    cdef double[:] F
    cdef Stat stat

    n = len(lam)

    F = np.empty(n-1, dtype=np.double)

    interp_specgrid_flux(<void *>specgrid, &x_vec[0], n, &lam[0], &F[0], &stat, &deriv_vec[0])
    _handle_error(stat)

    return F


# photgrid

def _load_photgrid(str photgrid_filename):

    cdef void *photgrid
    cdef Stat stat

    load_photgrid(photgrid_filename.encode('ascii'), &photgrid, &stat)
    _handle_error(stat)

    return <uintptr_t>photgrid


def _load_photgrid_from_specgrid(str specgrid_filename, str passband_filename):

    cdef void *photgrid
    cdef Stat stat

    load_photgrid_from_specgrid(specgrid_filename.encode('ascii'), passband_filename.encode('ascii'), &photgrid, &stat)
    _handle_error(stat)

    return <uintptr_t>photgrid


def _unload_photgrid(uintptr_t photgrid):

    unload_photgrid(<void *>photgrid)


def _get_photgrid_rank(uintptr_t photgrid):
    
    cdef int rank

    get_photgrid_rank(<void *>photgrid, &rank)

    return rank


def _get_photgrid_cache_count(uintptr_t photgrid):

    cdef int cache_count

    get_photgrid_cache_count(<void *>photgrid, &cache_count)

    return cache_count


def _get_photgrid_cache_limit(uintptr_t photgrid):

    cdef int cache_limit
    
    get_photgrid_cache_limit(<void *>photgrid, &cache_limit)

    return cache_limit


def _get_photgrid_axis_x_min(uintptr_t photgrid, int i):

    cdef double x_min
    
    get_photgrid_axis_x_min(<void *>photgrid, i, &x_min)

    return x_min


def _get_photgrid_axis_x_max(uintptr_t photgrid, int i):

    cdef double x_max
    
    get_photgrid_axis_x_max(<void *>photgrid, i, &x_max)

    return x_max


def _get_photgrid_axis_label(uintptr_t photgrid, int i):

    cdef char label[17]
    
    get_photgrid_axis_label(<void *>photgrid, i, label)

    return label.decode('ascii')


def _set_photgrid_cache_limit(uintptr_t photgrid, int cache_limit):

    cdef Stat stat

    set_photgrid_cache_limit(<void *>photgrid, cache_limit, &stat)
    _handle_error(stat)

    
def _interp_photgrid_intensity(uintptr_t photgrid, double[:] x_vec, double mu, bool[:] deriv_vec):

    cdef double I
    cdef Stat stat

    interp_photgrid_intensity(<void *>photgrid, &x_vec[0], mu, &I, &stat, &deriv_vec[0])
    _handle_error(stat)

    return I


def _interp_photgrid_E_moment(uintptr_t photgrid, double[:] x_vec, int k, bool[:] deriv_vec):

    cdef double E
    cdef Stat stat

    interp_photgrid_E_moment(<void *>photgrid, &x_vec[0], k, &E, &stat, &deriv_vec[0])
    _handle_error(stat)

    return E


def _interp_photgrid_D_moment(uintptr_t photgrid, double[:] x_vec, int l, bool[:] deriv_vec):

    cdef double D
    cdef Stat stat

    interp_photgrid_D_moment(<void *>photgrid, &x_vec[0], l, &D, &stat, &deriv_vec[0])
    _handle_error(stat)

    return D


def _interp_photgrid_flux(uintptr_t photgrid, double[:] x_vec, bool[:] deriv_vec):

    cdef double F
    cdef Stat stat

    interp_photgrid_flux(<void *>photgrid, &x_vec[0], &F, &stat, &deriv_vec[0])
    _handle_error(stat)

    return F


# shared

def _get_msg_version():

    cdef char version[17]

    get_msg_version(version)

    return version.decode('ascii')


def _handle_error(stat):

    # Take action based on the stat value

    if stat == STAT_OK:
        return
    elif stat == STAT_OUT_OF_BOUNDS_AXIS_LO:
        raise ValueError('out-of-bounds (lo) axis')
    elif stat == STAT_OUT_OF_BOUNDS_AXIS_HI:
        raise ValueError('out-of-bounds (hi) axis')
    elif stat == STAT_OUT_OF_BOUNDS_LAM_LO:
        raise ValueError('out-of-bounds (lo) lam')
    elif stat == STAT_OUT_OF_BOUNDS_LAM_HI:
        raise ValueError('out-of-bounds (hi) lam')
    elif stat == STAT_OUT_OF_BOUNDS_MU_LO:
        raise ValueError('out-of-bounds (lo) mu')
    elif stat == STAT_OUT_OF_BOUNDS_MU_HI:
        raise ValueError('out-of-bounds (hi) mu')
    elif stat == STAT_UNAVAILABLE_DATA:
        raise LookupError('unavailable data')
    elif stat == STAT_INVALID_ARGUMENT:
        raise ValueError('invalid argument')
    elif stat == STAT_FILE_NOT_FOUND:
        raise FileNotFoundError('file not found')
    elif stat == STAT_INVALID_FILE_TYPE:
        raise IOError('invalid file type')
    elif stat == STAT_INVALID_GROUP_TYPE:
        raise IOError('invalid group type')
    elif stat == STAT_INVALID_GROUP_REVISION:
        raise IOError('invalid group revision')
    else:
        raise Exception(f'error with unknown stat code: {stat}')

