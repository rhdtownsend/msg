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
from libcpp cimport bool

cdef extern from "libcmsg.h":

    void *specgrid_load(const char *filename)
    void *specgrid_load_rebin(const char *filename, double w_0, double dw, int n_w)
    void specgrid_unload(void *ptr)
    void specgrid_inquire(void *ptr, double *w_0, double *n_w, int *dw, int *shape, int *rank)
    void specgrid_get_label(void *ptr, int i, char *label)
    void specgrid_interp_intensity(void *ptr, double *vx, double mu, double w_0, int n_w, double I[], int *stat, bool *vderiv)
    void specgrid_interp_d_moment(void *ptr, double *vx, int l, double w_0, int n_w, double D[], int *stat, bool *vderiv)
    void specgrid_interp_flux(void *ptr, double *vx, double w_0, int n_w, double F[], int *stat, bool *vderiv)

    void *photgrid_load(const char *filename)
    void photgrid_unload(void *ptr)
    void photgrid_inquire(void *ptr, int *shape, int *rank)
    void photgrid_get_label(void *ptr, int i, char *label)
    void photgrid_interp_intensity(void *ptr, double *vx, double mu, double *I, int *stat, bool *vderiv)
    void photgrid_interp_d_moment(void *ptr, double *vx, int l, double *D, int *stat, bool *vderiv)
    void photgrid_interp_flux(void *ptr, double *vx, double *F, int *stat, bool *vderiv)


cdef class MsgError(Exception):

    def __init__(self, stat):

        if stat == 1:
            self.message = 'out-of-bounds (lo) axis'
        elif stat == 2:
            self.message = 'out-of-bounds (hi) axis'
        elif stat == 3:
            self.message = 'out-of-bounds (lo) w'
        elif stat == 4:
            self.message = 'out-of-bounds (hi) w'
        elif stat == 5:
            self.message = 'out-of-bounds (lo) mu'
        elif stat == 6:
            self.message = 'out-of-bounds (hi) mu'
        elif stat == 7:
            self.message = 'invalid l'
        elif stat == 8:
            self.message = 'unavailable data'
        else:
            self.message = f'error with unknown stat code: {stat}'

            
    def __str__(self):
        return self.message


    
cdef class SpecGrid:

    cdef void *ptr
    cdef int[:] shape
    cdef int rank
    cdef list labels

    def __cinit__(self, str filename, rebin_pars=None):

        if rebin_pars:
            w_0, dw, n_w = rebin_pars
            self.ptr = specgrid_load_rebin(filename.encode('ascii'), w_0, dw, n_w)
        else:
            self.ptr = specgrid_load(filename.encode('ascii'))

        specgrid_inquire(self.ptr, NULL, NULL, NULL, NULL, &self.rank)

        self.shape = np.empty(self.rank, dtype=np.intc)
        specgrid_inquire(self.ptr, NULL, NULL, NULL, &self.shape[0], NULL)

        self.labels = []
        cdef char label[17]
        for j in range(self.rank):
            specgrid_get_label(self.ptr, j+1, label)
            self.labels += [label.decode('ascii')]

        print('Shape:', np.asarray(self.shape))
        print('Labels:', self.labels)

        
    def __dealloc__(self):

        specgrid_unload(self.ptr)

        
    def intensity(self, dict dx, double mu, double w_0, int n_w, dict deriv=None):

        cdef double[:] I
        cdef int stat
        cdef double[:] vx
        cdef bool[:] vderiv

        I = np.empty(n_w, dtype=np.double)
        vx = np.array([dx[key] for key in self.labels])

        print(vx[0])

        if deriv is not None:
            vderiv = np.array([key in deriv for key in self.labels], dtype=np.uint8)
        else:
            vderiv = np.array([False]*self.rank, dtype=np.uint8)

        specgrid_interp_intensity(self.ptr, &vx[0], mu, w_0, n_w, &I[0], &stat, &vderiv[0])

        if stat != 0:
            raise MsgError(stat)

        return np.asarray(I)

    
    def D_moment(self, dict dx, int l, double w_0, int n_w, dict deriv=None):

        cdef double[:] D
        cdef int stat
        cdef double[:] vx
        cdef bool[:] vderiv

        D = np.empty(n_w, dtype=np.double)
        vx = np.array([dx[key] for key in self.labels])

        if deriv is not None:
            vderiv = np.array([key in deriv for key in self.labels], dtype=np.uint8)
        else:
            vderiv = np.array([False]*self.rank, dtype=np.uint8)

        specgrid_interp_d_moment(self.ptr, &vx[0], l, w_0, n_w, &D[0], &stat, &vderiv[0])

        if stat != 0:
            raise MsgError(stat)

        return np.asarray(D)

    
    def flux(self, dict dx, double w_0, int n_w, dict deriv):

        cdef double[:] F
        cdef int stat
        cdef double[:] vx
        cdef bool[:] vderiv

        F = np.empty(n_w, dtype=np.double)
        vx = np.array([dx[key] for key in self.labels])

        if deriv is not None:
            vderiv = np.array([key in deriv for key in self.labels], dtype=np.uint8)
        else:
            vderiv = np.array([False]*self.rank, dtype=np.uint8)

        specgrid_interp_flux(self.ptr, &vx[0], w_0, n_w, &F[0], &stat, &vderiv[0])
        if stat != 0:
            raise MsgError(stat)
        
        return np.asarray(F)


cdef class PhotGrid:

    cdef void *ptr
    cdef int[:] shape
    cdef int rank
    cdef list labels

    def __cinit__(self, str filename):

        self.ptr = photgrid_load(filename.encode('ascii'))

        photgrid_inquire(self.ptr, NULL, &self.rank)

        self.shape = np.empty(self.rank, dtype=np.intc)
        photgrid_inquire(self.ptr, &self.shape[0], NULL)

        self.labels = []
        cdef char label[17]
        for j in range(self.rank):
            photgrid_get_label(self.ptr, j+1, label)
            self.labels += [label.decode('ascii')]

        print('Shape:', np.asarray(self.shape))
        print('Labels:', self.labels)

        
    def __dealloc__(self):
        
        photgrid_unload(self.ptr)

        
    def intensity(self, dict dx, double mu, dict deriv=None):

        cdef double I
        cdef int stat
        cdef double[:] vx
        cdef bool[:] vderiv

        vx = np.array([dx[key] for key in self.labels])

        if deriv is not None:
            vderiv = np.array([key in deriv for key in self.labels], dtype=np.uint8)
        else:
            vderiv = np.array([False]*self.rank, dtype=np.uint8)

        photgrid_interp_intensity(self.ptr, &vx[0], mu, &I, &stat,  NULL)
        if stat != 0:
            raise MsgError(stat)

        return I

    
    def D_moment(self, dict dx, int l, dict deriv=None):

        cdef double D
        cdef int stat
        cdef double[:] vx
        cdef bool[:] vderiv

        vx = np.array([dx[key] for key in self.labels])

        if deriv is not None:
            vderiv = np.array([key in deriv for key in self.labels], dtype=np.uint8)
        else:
            vderiv = np.array([False]*self.rank, dtype=np.uint8)
            
        photgrid_interp_d_moment(self.ptr, &vx[0], l, &D, &stat, &vderiv[0])
        if stat != 0:
            raise MsgError(stat)

        return D

    
    def flux(self, dict dx, dict deriv=None):

        cdef double F
        cdef int stat
        cdef double[:] vx
        cdef bool[:] vderiv

        vx = np.array([dx[key] for key in self.labels])

        if deriv is not None:
            vderiv = np.array([key in deriv for key in self.labels], dtype=np.uint8)
        else:
            vderiv = np.array([False]*self.rank, dtype=np.uint8)
            
        photgrid_interp_flux(self.ptr, &vx[0], &F, &stat, &vderiv[0])
        if stat != 0:
            raise MsgError(stat)

        return F
