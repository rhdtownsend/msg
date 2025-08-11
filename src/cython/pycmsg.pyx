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

    cdef int cache_usage

    get_specgrid_cache_usage(<void *>specgrid, &cache_usage)

    return cache_usage


def _get_specgrid_cache_limit(uintptr_t specgrid):

    cdef int cache_limit
    
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


def _set_specgrid_cache_limit(uintptr_t specgrid, int cache_limit):

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


def _flush_specgrid_cache(uintptr_t specgrid):

    flush_specgrid_cache(<void *>specgrid)


def _interp_specgrid_intensity(uintptr_t specgrid, double[:] x_vec, double mu, double z, double[:] lam,
                               bool[:] deriv_vec, int order):

    cdef double[:] I
    cdef Stat stat

    n = len(lam)
    r = len(x_vec)

    I = np.empty(n-1, dtype=np.double)

    interp_specgrid_intensity(<void *>specgrid, n, r, &x_vec[0], mu, z, &lam[0], &I[0], &stat, &deriv_vec[0], &order)
    _handle_error(stat)

    return np.asarray(I)


def _interp_specgrid_E_moment(uintptr_t specgrid, double[:] x_vec, int k, double z, double[:] lam,
                              bool[:] deriv_vec, int order):

    cdef double[:] E
    cdef Stat stat

    n = len(lam)
    r = len(x_vec)

    E = np.empty(n-1, dtype=np.double)

    interp_specgrid_E_moment(<void *>specgrid, n, r, &x_vec[0], k, z, &lam[0], &E[0], &stat, &deriv_vec[0], &order)
    _handle_error(stat)

    return np.asarray(E)


def _interp_specgrid_P_moment(uintptr_t specgrid, double[:] x_vec, int l, double z, double[:] lam,
                              bool[:] deriv_vec, int order):

    cdef double[:] P
    cdef Stat stat

    n = len(lam)
    r = len(x_vec)

    P = np.empty(n-1, dtype=np.double)

    interp_specgrid_P_moment(<void *>specgrid, n, r, &x_vec[0], l, z, &lam[0], &P[0], &stat, &deriv_vec[0], &order)
    _handle_error(stat)

    return np.asarray(P)


def _interp_specgrid_irradiance(uintptr_t specgrid, double[:,::1] x_vec, double[:] mu, double[:] dOmega,
                                double[:] z, double[:] lam, bool[:] deriv_vec, int order):

    cdef double[:] F
    cdef Stat stat

    n = len(lam)
    m = x_vec.shape[0]
    r = x_vec.shape[1]

    F = np.empty(n-1, dtype=np.double)

    interp_specgrid_irradiance(<void *>specgrid, n, m, r, &x_vec[0,0], &mu[0], &dOmega[0],
                               &z[0], &lam[0], &F[0], &stat, &deriv_vec[0], &order)
    _handle_error(stat)

    return np.asarray(F)


def _interp_specgrid_flux(uintptr_t specgrid, double[:] x_vec, double z, double[:] lam, bool[:] deriv_vec, int order):

    cdef double[:] F
    cdef Stat stat

    n = len(lam)
    r = len(x_vec)

    F = np.empty(n-1, dtype=np.double)

    interp_specgrid_flux(<void *>specgrid, n, r, &x_vec[0], z, &lam[0], &F[0], &stat, &deriv_vec[0], &order)
    _handle_error(stat)

    return np.asarray(F)


def _adjust_specgrid_x_vec(uintptr_t specgrid, double[:] x_vec, double[:] dx_vec):

    cdef double[:] x_adj
    cdef Stat stat

    r = len(x_vec)

    x_adj = np.empty(r, dtype=np.double)

    adjust_specgrid_x_vec(<void *>specgrid, r, &x_vec[0], &dx_vec[0], &x_adj[0], &stat)
    _handle_error(stat)

    return x_adj


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


def _get_photgrid_cache_usage(uintptr_t photgrid):

    cdef int cache_usage

    get_photgrid_cache_usage(<void *>photgrid, &cache_usage)

    return cache_usage


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

    
def _flush_photgrid_cache(uintptr_t photgrid):

    flush_photgrid_cache(<void *>photgrid)


def _interp_photgrid_intensity(uintptr_t photgrid, double[:] x_vec, double mu, bool[:] deriv_vec, int order):

    cdef double I
    cdef Stat stat

    r = len(x_vec)

    interp_photgrid_intensity(<void *>photgrid, r, &x_vec[0], mu, &I, &stat, &deriv_vec[0], &order)
    _handle_error(stat)

    return I


def _interp_photgrid_E_moment(uintptr_t photgrid, double[:] x_vec, int k, bool[:] deriv_vec, int order):

    cdef double M
    cdef Stat stat

    r = len(x_vec)

    interp_photgrid_E_moment(<void *>photgrid, r, &x_vec[0], k, &M, &stat, &deriv_vec[0], &order)
    _handle_error(stat)

    return M


def _interp_photgrid_P_moment(uintptr_t photgrid, double[:] x_vec, int l, bool[:] deriv_vec, int order):

    cdef double P
    cdef Stat stat

    r = len(x_vec)

    interp_photgrid_P_moment(<void *>photgrid, r, &x_vec[0], l, &P, &stat, &deriv_vec[0], &order)
    _handle_error(stat)

    return P


def _interp_photgrid_irradiance(uintptr_t photgrid, double[:,::1] x_vec, double[:] mu, double[:] dOmega,
                                bool[:] deriv_vec, int order):

    cdef double F
    cdef Stat stat

    m = x_vec.shape[0]
    r = x_vec.shape[1]

    interp_photgrid_irradiance(<void *>photgrid, m, r, &x_vec[0,0], &mu[0], &dOmega[0],
                               &F, &stat, &deriv_vec[0], &order)
    _handle_error(stat)

    return np.asarray(F)


def _interp_photgrid_flux(uintptr_t photgrid, double[:] x_vec, bool[:] deriv_vec, int order):

    cdef double F
    cdef Stat stat

    r = len(x_vec)

    interp_photgrid_flux(<void *>photgrid, r, &x_vec[0], &F, &stat, &deriv_vec[0], &order)
    _handle_error(stat)

    return F


def _adjust_photgrid_x_vec(uintptr_t photgrid, double[:] x_vec, double[:] dx_vec):

    cdef double[:] x_adj
    cdef Stat stat

    r = len(x_vec)

    x_adj = np.empty(r, dtype=np.double)

    adjust_photgrid_x_vec(<void *>photgrid, r, &x_vec[0], &dx_vec[0], &x_adj[0], &stat)
    _handle_error(stat)

    return x_adj


# shared

def _get_msg_version():

    cdef char version[17]

    get_msg_version(version)

    return version.decode('ascii')


def _handle_error(stat):

    # Take action based on the stat value

    if stat == STAT_OK:
        return
    elif stat == STAT_INVALID_DIMENSION:
        raise ValueError('invalid dimension')
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
    elif stat == STAT_INVALID_OMP_CONFIG:
        raise OSError('invalid OpenMP configuration')
    else:
        raise Exception(f'error with unknown stat code: {stat}')

