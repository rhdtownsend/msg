#cython: language_level=3
#
# Module  : pymsg_photgrid
# Purpose : Cython interface to libcmsg (photgrid part)
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
cimport numpy as cnp
cimport cython

from libcpp cimport bool

from pymsg.pymsg_common import *

# C definitions

cdef extern from "cmsg.h":

    void load_photgrid(const char *photgrid_file_name, void **photgrid, int *stat)
    void load_photgrid_from_specgrid(const char *specgrid_file_name,
                                     const char *passband_filename, void **photgrid, int *stat)
    void unload_photgrid(void *photgrid)

    void get_photgrid_rank(void *photgrid, int *rank)
    void get_photgrid_cache_count(void *photgrid, int *cache_count)
    void get_photgrid_cache_limit(void *photgrid, int *cache_limit)
    void get_photgrid_axis_x_min(void *photgrid, int i, double *axis_x_min)
    void get_photgrid_axis_x_max(void *photgrid, int i, double *axis_x_max)
    void get_photgrid_axis_label(void *photgrid, int i, char *axis_label)

    void set_photgrid_cache_limit(void *photgrid, int *cache_limit, int *stat)

    void interp_photgrid_intensity(void *photgrid, double x_vec[], double mu,
                                   double *I, int *stat, bool deriv_vec[])
    void interp_photgrid_e_moment(void *photgrid, double x_vec[], int k, double *E,
                                  int *stat, bool deriv_vec[])
    void interp_photgrid_d_moment(void *photgrid, double x_vec[], int l, double *D,
                                  int *stat, bool deriv_vec[])
    void interp_photgrid_flux(void *photgrid, double x_vec[], double *F, int *stat,
                              bool deriv_vec[])


# Class definition
    
@cython.binding(True)
cdef class PhotGrid:
    r"""The PhotGrid class represents a grid of photometric intensity data.

    This grid may be used to interpolate the intensity (or related
    quantities) for a set of atmospheric parameter values.

    """

    cdef void *photgrid
    
    cdef readonly int rank
    """int: Number of atmospheric parameter axes."""
    cdef readonly list axis_labels
    """list: Atmospheric parameter axes labels."""
    cdef readonly dict axis_min
    """dict: Atmospheric parameter axis minima."""
    cdef readonly dict axis_max
    """dict: Atmospheric parameter axis maxima."""

    
    def __init__(self, str filename, str passband_filename=None):
        """PhotGrid constructor.

        Args:
            filename (string): Full pathname of grid file to load.
            passband (string): Full pathname of passband (for dynamic 
               loading from a specgrid)
        Raises:
            FileNotFound: If the the file cannot be found.
            TypeError: If the file contains an incorrect datatype.
        """

        cdef int stat

        if passband_filename is not None:
            load_photgrid_from_specgrid(filename.encode('ascii'),
                                        passband_filename.encode('ascii'),
                                        &self.photgrid, &stat)
        else:
            load_photgrid(filename.encode('ascii'), &self.photgrid, &stat)

        handle_error(stat)

        get_photgrid_rank(self.photgrid, &self.rank)

        self.axis_labels = []
        self.axis_min = {}
        self.axis_max = {}

        cdef char label[17]
        cdef double x_min
        cdef double x_max

        for j in range(self.rank):

            get_photgrid_axis_label(self.photgrid, j+1, label)
            get_photgrid_axis_x_min(self.photgrid, j+1, &x_min)
            get_photgrid_axis_x_max(self.photgrid, j+1, &x_max)

            axis_label = label.decode('ascii')

            self.axis_labels += [axis_label]
            self.axis_min[axis_label] = x_min
            self.axis_max[axis_label] = x_max


    def __dealloc__(self):
        
        unload_photgrid(self.photgrid)

        
    def _vector_args(self, x, deriv):

        x_vec = np.array([x[key] for key in self.axis_labels])

        if deriv is not None:
            deriv_vec = np.array([key in deriv for key in self.axis_labels],
                                 dtype=np.uint8)
        else:
            deriv_vec = np.array([False]*self.rank, dtype=np.uint8)

        return x_vec, deriv_vec
    
        
    @property
    def cache_count(self):
        """int: Number of nodes currently in cache."""
        cdef int count
        get_photgrid_cache_count(self.photgrid, &count)
        return count


    @property
    def cache_limit(self):
        """double: Maximum number of nodes to hold in cache. Set to 0 to disable 
        chaching, or to None to reset to default."""
        cdef int limit
        get_photgrid_cache_limit(self.photgrid, &limit)
        return limit

    @cache_limit.setter
    def cache_limit(self, cache_limit):
        cdef int stat
        cdef int limit
        if cache_limit is not None:
            limit = int(cache_limit)
            set_photgrid_cache_limit(self.photgrid, &limit, &stat)
        else:
            set_photgrid_cache_limit(self.photgrid, NULL, &stat)
        handle_error(stat)


    def intensity(self, dict x, double mu, dict deriv=None):
        r"""Evaluate the photometric intensity, normalized to the zero-
            point flux.

        Args:
            x (dict): Atmospheric parameters; keys must match 
                `axis_labels` property, values must be double.
            mu (double): Cosine of angle of emergence relative to 
                surface normal.
            deriv (dict, optional): Flags indicating whether to evaluate 
                derivative with respect to each atmospheric parameter; 
                keys must match the `axis_labels` property, values must 
                be boolean.

        Returns:
            double: photometric intensity (/sr).

        Raises:
            KeyError: If `x` does not define all keys appearing in the
                `axis_labels` property.
            ValueError: If `x` or `mu` falls outside the bounds of the 
                grid.
            LookupError: If `x` falls in a grid void.
        """

        cdef double I
        cdef int stat
        cdef double[:] x_vec
        cdef bool[:] deriv_vec

        x_vec, deriv_vec = self._vector_args(x, deriv)

        interp_photgrid_intensity(self.photgrid, &x_vec[0], mu, &I, &stat,
                                  &deriv_vec[0])
        handle_error(stat)

        return I

    
    def E_moment(self, dict x, int k, dict deriv=None):
        r"""Evaluate the photometric intensity E-moment, normalized to
            the zero-point flux.

        Args:
            x (dict): Atmospheric parameters; keys must match
                `axis_labels` property, values must be double.
            k (int): Degree of moment.
            deriv (dict, optional): Flags indicating whether to evaluate 
                derivative with respect to each atmospheric parameter; 
                keys must match the `axis_labels` property, values must 
                be boolean.

        Returns:
            double: photometric intensity E-moment.

        Raises:
            KeyError: If `x` does not define all keys appearing in the
                `axis_labels` property.
            ValueError: If `x` or `k` falls outside the bounds of the 
                grid.
            LookupError: If `x` falls in a grid void.
       """

        cdef double E
        cdef int stat
        cdef double[:] x_vec
        cdef bool[:] deriv_vec

        x_vec, deriv_vec = self._vector_args(x, deriv)

        interp_photgrid_e_moment(self.photgrid, &x_vec[0], k, &E, &stat,
                                 &deriv_vec[0])
        handle_error(stat)

        return E

    
    def D_moment(self, dict x, int l, dict deriv=None):
        r"""Evaluate the photometric intensity D-moment, normalized to
            the zero-point flux.

        Args:
            x (dict): Atmospheric parameters; keys must match
                `axis_labels` property, values must be double.
            l (int): Harmonic degree of moment.
            deriv (dict, optional): Flags indicating whether to evaluate 
                derivative with respect to each atmospheric parameter; 
                keys must match the `axis_labels` property, values must 
                be boolean.

        Returns:
            double: photometric intensity D-moment.

        Raises:
            KeyError: If `x` does not define all keys appearing in the
                `axis_labels` property.
            ValueError: If `x` or `l` falls outside the bounds of the 
                grid.
            LookupError: If `x` falls in a grid void.
       """

        cdef double D
        cdef int stat
        cdef double[:] x_vec
        cdef bool[:] deriv_vec

        x_vec, deriv_vec = self._vector_args(x, deriv)

        interp_photgrid_d_moment(self.photgrid, &x_vec[0], l, &D, &stat,
                                 &deriv_vec[0])
        handle_error(stat)

        return D

    
    def flux(self, dict x, dict deriv=None):
        r"""Evaluate the photometric flux, normalized to the zero-point
            flux.

        Args:
            x (dict): Atmospheric parameters; keys must match
                `axis_labels` property, values must be double.
            deriv (dict, optional): Flags indicating whether to evaluate 
                derivative with respect to each atmospheric parameter; 
                keys must match the `axis_labels` property, values must 
                be boolean.

        Returns:
            double: photometric flux.

        Raises:
            KeyError: If `x` does not define all keys appearing in the
                `axis_labels` property.
            ValueError: If `x` or `l` falls outside the bounds of the 
                grid.
            LookupError: If `x` falls in a grid void.
       """

        cdef double F
        cdef int stat
        cdef double[:] x_vec
        cdef bool[:] deriv_vec

        x_vec, deriv_vec = self._vector_args(x, deriv)

        interp_photgrid_flux(self.photgrid, &x_vec[0], &F, &stat, &deriv_vec[0])
        handle_error(stat)

        return F
