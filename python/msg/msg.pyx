#cython: language_level=3
#
# Module  : msg
# Purpose : Cython interface to libcmsg
#
# Copyright 2021 Rich Townsend & The MSG Team
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

cdef extern from "libcmsg.h":

    void *specgrid_load(const char *filename)
    void *specgrid_load_rebin(const char *filename, double w_0, double dw, int n_w)
    void specgrid_unload(void *ptr)
    void specgrid_inquire(void *ptr, double *w_0, double *n_w, int *dw, int *n_logT, int *n_logg)
    void specgrid_interp_intensity(void *ptr, double logT, double logg, double mu, double w_0, int n_w, double I[], int *stat, bint d_dlogT, bint d_dlogg)
    void specgrid_interp_d_moment(void *ptr, double logT, double logg, int l, double w_0, int n_w, double D[], int *stat, bint d_dlogT, bint d_dlogg)
    void specgrid_interp_flux(void *ptr, double logT, double logg, double w_0, int n_w, double F[], int *stat, bint d_dlogT, bint d_dlogg)

    void *photgrid_load(const char *filename)
    void photgrid_unload(void *ptr)
    void photgrid_inquire(void *ptr, int *n_logT, int *n_logg)
    void photgrid_interp_intensity(void *ptr, double logT, double logg, double mu, double *I, int *stat, bint d_dlogT, bint d_dlogg)
    void photgrid_interp_d_moment(void *ptr, double logT, double logg, int l, double *D, int *stat, bint d_dlogT, bint d_dlogg)
    void photgrid_interp_flux(void *ptr, double logT, double logg, double *F, int *stat, bint d_dlogT, bint d_dlogg)


cdef class MsgError(Exception):

    def __init__(self, stat):

        if stat == 1:
            self.message = 'out-of-bounds (lo) logT'
        elif stat == 2:
            self.message = 'out-of-bounds (hi) logT'
        elif stat == 3:
            self.message = 'out-of-bounds (lo) logg'
        elif stat == 4:
            self.message = 'out-of-bounds (hi) logg'
        elif stat == 5:
            self.message = 'out-of-bounds (lo) w'
        elif stat == 6:
            self.message = 'out-of-bounds (hi) w'
        elif stat == 7:
            self.message = 'out-of-bounds (lo) mu'
        elif stat == 8:
            self.message = 'out-of-bounds (hi) mu'
        elif stat == 9:
            self.message = 'invalid l'
        elif stat == 10:
            self.message = 'unavailable data'
        else:
            self.message = f'error with unknown stat code: {stat}'

    def __str__(self):
        return self.message


cdef class SpecGrid:

    cdef void *ptr

    def __cinit__(self, const char *filename, rebin_pars=None):
        cdef int n_logT, n_logg
        if rebin_pars:
            w_0, dw, n_w = rebin_pars
            self.ptr = specgrid_load_rebin(filename, w_0, dw, n_w)
        else:
            self.ptr = specgrid_load(filename)
        specgrid_inquire(self.ptr, NULL, NULL, NULL, &n_logT, &n_logg)
        print('Dims:', n_logT, n_logg)

    def __dealloc__(self):
        specgrid_unload(self.ptr)

    def intensity(self, double logT, double logg, double mu, double w_0, int n_w, bint d_dlogT=False, bint d_dlogg=False):
        I = np.empty(n_w, dtype=np.double)
        cdef double[:] I_view = I
        cdef int stat
        specgrid_interp_intensity(self.ptr, logT, logg, mu, w_0, n_w, &I_view[0], &stat, d_dlogT, d_dlogg)
        if stat != 0:
            raise MsgError(stat)
        return I

    def D_moment(self, double logT, double logg, int l, double w_0, int n_w, bint d_dlogT=False, bint d_dlogg=False):
        D = np.empty(n_w, dtype=np.double)
        cdef double[:] D_view = D
        cdef int stat
        specgrid_interp_d_moment(self.ptr, logT, logg, l, w_0, n_w, &D_view[0], &stat, d_dlogT, d_dlogg)
        if stat != 0:
            raise MsgError(stat)
        return D

    def flux(self, double logT, double logg, double w_0, int n_w, bint d_dlogT=False, bint d_dlogg=False):
        F = np.empty(n_w, dtype=np.double)
        cdef double[:] F_view = F
        cdef int stat
        specgrid_interp_flux(self.ptr, logT, logg, w_0, n_w, &F_view[0], &stat, d_dlogT, d_dlogg)
        if stat != 0:
            raise MsgError(stat)
        return F


cdef class PhotGrid:

    cdef void *ptr

    def __cinit__(self, const char *filename):
        self.ptr = photgrid_load(filename)

    def __dealloc__(self):
        photgrid_unload(self.ptr)

    def intensity(self, double logT, double logg, double mu, bint d_dlogT=False, bint d_dlogg=False):
        cdef double I
        cdef int stat
        photgrid_interp_intensity(self.ptr, logT, logg, mu, &I, &stat, d_dlogT, d_dlogg)
        if stat != 0:
            raise MsgError(stat)
        return I

    def D_moment(self, double logT, double logg, int l, bint d_dlogT=False, bint d_dlogg=False):
        cdef double D
        cdef int stat
        photgrid_interp_d_moment(self.ptr, logT, logg, l, &D, &stat, d_dlogT, d_dlogg)
        if stat != 0:
            raise MsgError(stat)
        return D

    def flux(self, double logT, double logg, bint d_dlogT=False, bint d_dlogg=False):
        cdef double F
        cdef int stat
        photgrid_interp_flux(self.ptr, logT, logg, &F, &stat, d_dlogT, d_dlogg)
        if stat != 0:
            raise MsgError(stat)
        return F
