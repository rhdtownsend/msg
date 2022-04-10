#cython: language_level=3
#
# Module  : pymsg_specgrid
# Purpose : Cython interface to libcmsg (specgrid part)
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

    void load_specgrid(const char *specgrid_filename, void **specgrid, int *stat)
    void unload_specgrid(void *specgrid)

    void get_specgrid_rank(void *specgrid, int *rank)
    void get_specgrid_cache_count(void *specgrid, int *cache_count)
    void get_specgrid_cache_limit(void *specgrid, int *cache_limit)
    void get_specgrid_cache_lam_min(void *specgrid, double *cache_lam_min)
    void get_specgrid_cache_lam_max(void *specgrid, double *cache_lam_max)
    void get_specgrid_axis_x_min(void *specgrid, int i, double *axis_x_min)
    void get_specgrid_axis_x_max(void *specgrid, int i, double *axis_x_max)
    void get_specgrid_axis_label(void *specgrid, int i, char *axis_label)

    void set_specgrid_cache_limit(void *specgrid, int *cache_limit, int *stat)
    void set_specgrid_cache_lam_min(void *specgrid, double *cache_lam_min, int *stat)
    void set_specgrid_cache_lam_max(void *specgrid, double *cache_lam_max, int *stat)

    void interp_specgrid_intensity(void *specgrid, double x_vec[], double mu,
                                   int n, double lam[], double I[], int *stat,
                                   bool deriv_vec[])
    void interp_specgrid_e_moment(void *specgrid, double x_vec[], int k, int n,
                                  double lam[], double E[], int *stat, bool deriv_vec[])
    void interp_specgrid_d_moment(void *specgrid, double x_vec[], int l, int n,
                                  double lam[], double D[], int *stat, bool deriv_vec[])
    void interp_specgrid_flux(void *specgrid, double x_vec[], int n, double lam[],
                              double F[], int *stat, bool deriv_vec[])
    

# Class definition

@cython.binding(True)
cdef class SpecGrid:
    r"""The SpecGrid class represents a grid of spectroscopic intensity data.

    This grid may be used to interpolate the intensity (or related
    quantities) across a wavelength abscissa and for a set of
    atmospheric parameter values.

    """

    cdef void *specgrid
    
    cdef readonly int rank
    """int: Number of dimensions in grid."""
    cdef readonly list axis_labels
    """list: Atmospheric parameter axis labels."""
    cdef readonly dict axis_min
    """dict: Atmospheric parameter axis minima."""
    cdef readonly dict axis_max
    """dict: Atmospheric parameter axis maxima."""
    
    def __init__(self, str filename):
        """SpecGridg constructor.

        Args:
            filename (string): Filename of grid to load.
	    cache_limit (int): Limit on number of spectra to cache in memory. If
	       not specified, no limits are placed on the cache growth. Conversely,
	       if set to zero, caching is disabled (with a likely performance impact).
	       omit to allow for unlimited caching.
        Raises:
            FileNotFound: If the the file cannot be found.
            TypeError: If the file contains an incorrect datatype.
        """

        cdef int stat

        load_specgrid(filename.encode('ascii'), &self.specgrid, &stat)
        handle_error(stat)

        get_specgrid_rank(self.specgrid, &self.rank)

        self.axis_labels = []
        self.axis_min = {}
        self.axis_max = {}

        cdef char label[17]
        cdef double x_min
        cdef double x_max

        for j in range(self.rank):

            get_specgrid_axis_label(self.specgrid, j+1, label)
            get_specgrid_axis_x_min(self.specgrid, j+1, &x_min)
            get_specgrid_axis_x_max(self.specgrid, j+1, &x_max)

            axis_label = label.decode('ascii')

            self.axis_labels += [axis_label]
            self.axis_min[axis_label] = x_min
            self.axis_max[axis_label] = x_max

        
    def __dealloc__(self):

        unload_specgrid(self.specgrid)


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
        get_specgrid_cache_count(self.specgrid, &count)
        return count


    @property
    def cache_limit(self):
        """double: Maximum number of nodes to hold in cache. Set to 0 to disable 
           caching, or to None to reset to default."""
        cdef int limit
        get_specgrid_cache_limit(self.specgrid, &limit)
        return limit

    @cache_limit.setter
    def cache_limit(self, cache_limit):
        cdef int stat
        cdef int limit
        if cache_limit is not None:
            limit = int(cache_limit)
            set_specgrid_cache_limit(self.specgrid, &limit, &stat)
        else:
            set_specgrid_cache_limit(self.specgrid, NULL, &stat)
        handle_error(stat)


    @property
    def cache_lam_min(self):
        """double: Minimum wavelength of cached spectra. Set to None to reset to 
        default."""
        cdef double lam_min
        get_specgrid_cache_lam_min(self.specgrid, &lam_min)
        return lam_min

    @cache_lam_min.setter
    def cache_lam_min(self, cache_lam_min):
        cdef int stat
        cdef double lam_min
        if cache_lam_min is not None:
            lam_min = float(cache_lam_min)
            set_specgrid_cache_lam_min(self.specgrid, &lam_min, &stat)
        else:
            set_specgrid_cache_lam_min(self.specgrid, NULL, &stat)
        handle_error(stat)


    @property
    def cache_lam_max(self):
        """double: Maximum wavelength of cached spectra. Set to None to reset to 
           default."""
        cdef double lam_max
        get_specgrid_cache_lam_max(self.specgrid, &lam_max)
        return lam_max

    @cache_lam_max.setter
    def cache_lam_max(self, cache_lam_max):
        cdef int stat
        cdef double lam_max
        if cache_lam_max is not None:
            lam_max = float(cache_lam_max)
            set_specgrid_cache_lam_max(self.specgrid, &lam_max, &stat)
        else:
            set_specgrid_cache_lam_max(self.specgrid, NULL, &stat)
        handle_error(stat)
        

    def intensity(self, dict x, double mu, double[:] lam,
                  dict deriv=None):
        r"""Evaluate the spectroscopic intensity.

        Args:
            x (dict): Atmospheric parameters; keys must match 
                `axis_labels` property, values must be double.b
            mu (double): Cosine of angle of emergence relative to 
                surface normal.
            lam (numpy.ndarray): Wavelength abscissa (Å).
            deriv (dict, optional): Flags indicating whether to evaluate 
                derivative with respect to each atmospheric parameter; 
                keys must match the `axis_labels` property, values must 
                be boolean.

        Returns:
            numpy.ndarray: Spectroscopic intensity (erg/cm^2/s/Å/sr) in
            bins delineated by lam; length len(lam)-1.

        Raises:
            KeyError: If `x` does not define all keys appearing in the
                `axis_labels` property.
            ValueError: If `x`, `mu`, or any part of the wavelength
                abscissa falls outside the bounds of the grid.
            LookupError: If `x` falls in a grid void.
        """

        cdef double[:] I
        cdef int stat
        cdef double[:] x_vec
        cdef bool[:] deriv_vec

        n = len(lam)

        I = np.empty(n-1, dtype=np.double)

        x_vec, deriv_vec = self._vector_args(x, deriv)

        interp_specgrid_intensity(self.specgrid, &x_vec[0], mu, n, &lam[0],
                                  &I[0], &stat, &deriv_vec[0])
        handle_error(stat)

        return np.asarray(I)

    
    def E_moment(self, dict x, int k, double[:] lam, dict deriv=None):
        r"""Evaluate the spectroscopic intensity E-moment.

        Args:
            x (dict): Atmospheric parameters; keys must match
                `axis_labels` property, values must be double.
            k (int): Degree of moment.
            lam (numpy.ndarray): Wavelength abscissa (Å).
            deriv (dict, optional): Flags indicating whether to evaluate 
                derivative with respect to each atmospheric parameter; 
                keys must match the `axis_labels` property, values must 
                be boolean.

        Returns:
            numpy.ndarray: Spectroscopic intensity E-moment 
            (erg/cm^2/s/Å) in bins delineated by lam; length len(lam)-1.

        Raises:
            KeyError: If `x` does not define all keys appearing in the
                `axis_labels` property.
            ValueError: If `x`, `k`, or any part of the wavelength
                abscissa falls outside the bounds of the grid.
            LookupError: If `x` falls in a grid void.
        """

        cdef double[:] E
        cdef int stat
        cdef double[:] x_vec
        cdef bool[:] deriv_vec

        n = len(lam)

        E = np.empty(n-1, dtype=np.double)

        x_vec, deriv_vec = self._vector_args(x, deriv)

        interp_specgrid_d_moment(self.specgrid, &x_vec[0], k, n, &lam[0], &E[0],
                                 &stat, &deriv_vec[0])
        handle_error(stat)

        return np.asarray(E)

    
    def D_moment(self, dict x, int l, double[:] lam, dict deriv=None):
        r"""Evaluate the spectroscopic intensity D-moment.

        Args:
            x (dict): Atmospheric parameters; keys must match
                `axis_labels` property, values must be double.
            l (int): Harmonic degree of moment.
            lam (numpy.ndarray): Wavelength abscissa (Å).
            deriv (dict, optional): Flags indicating whether to evaluate 
                derivative with respect to each atmospheric parameter; 
                keys must match the `axis_labels` property, values must 
                be boolean.

        Returns:
            numpy.ndarray: Spectroscopic intensity D-moment 
            (erg/cm^2/s/Å) in bins delineated by lam; length len(lam)-1.

        Raises:
            KeyError: If `x` does not define all keys appearing in the
                `axis_labels` property.
            ValueError: If `x`, `l`, or any part of the wavelength
                abscissa falls outside the bounds of the grid.
            LookupError: If `x` falls in a grid void.
        """

        cdef double[:] D
        cdef int stat
        cdef double[:] x_vec
        cdef bool[:] deriv_vec

        n = len(lam)

        D = np.empty(n-1, dtype=np.double)

        x_vec, deriv_vec = self._vector_args(x, deriv)

        interp_specgrid_e_moment(self.specgrid, &x_vec[0], l, n, &lam[0], &D[0],
                                 &stat, &deriv_vec[0])
        handle_error(stat)

        return np.asarray(D)

    
    def flux(self, dict x, double[:] lam, dict deriv=None):
        r"""Evaluate the spectroscopic flux.

        Args:
            x (dict): Atmospheric parameters; keys must match
                `axis_labels` property, values must be double.
            lam (numpy.ndarray): Wavelength abscissa (Å)
            deriv (dict, optional): Flags indicating whether to evaluate 
                derivative with respect to each atmospheric parameter; 
                keys must match the `axis_labels` property, values must 
                be boolean.

        Returns:
            numpy.ndarray: Spectroscopic flux (erg/cm^2/s/Å) in bins 
            delineated by lam; length len(lam)-1.

        Raises:
            KeyError: If `x` does not define all keys appearing in the
                `axis_labels` property.
            ValueError: If `x` or any part of the wavelength abscissa 
                falls outside the bounds of the grid.
            LookupError: If `x` falls in a grid void.
        """

        cdef double[:] F
        cdef int stat
        cdef double[:] x_vec
        cdef bool[:] deriv_vec

        n = len(lam)

        F = np.empty(n-1, dtype=np.double)

        x_vec, deriv_vec = self._vector_args(x, deriv)

        interp_specgrid_flux(self.specgrid, &x_vec[0], n, &lam[0], &F[0], &stat,
                             &deriv_vec[0])
        handle_error(stat)
        
        return np.asarray(F)
