#cython: language_level=3
#
# Module  : pymsg
# Purpose : Cython interface to libcmsg
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

# C definitions

cdef extern from "cmsg.h":

    # SpecGrid interface

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

    # PhotGrid interface

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

    # enums etc
    
    cdef enum:
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
        if stat != STAT_OK:
            handle_error(stat)

        get_specgrid_rank(&self.specgrid, &self.rank)

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


    def _vector_args(self, dx, deriv):

        vx = np.array([dx[key] for key in self.axis_labels])

        if deriv is not None:
            vderiv = np.array([key in deriv for key in self.axis_labels],
                              dtype=np.uint8)
        else:
            vderiv = np.array([False]*self.rank, dtype=np.uint8)

        return vx, vderiv


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
        if stat != STAT_OK:
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
        if stat != STAT_OK:
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
        if stat != STAT_OK:
            handle_error(stat)
        

    def intensity(self, dict dx, double mu, double[:] lam,
                  dict deriv=None):
        r"""Evaluate the spectroscopic intensity.

        Args:
            dx (dict): Atmospheric parameters; keys must match 
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
            KeyError: If `dx` does not define all keys appearing in the
                `axis_labels` property.
            ValueError: If `dx`, `mu`, or any part of the wavelength
                abscissa falls outside the bounds of the grid.
            LookupError: If `dx` falls in a grid void.
        """

        cdef double[:] I
        cdef int stat
        cdef double[:] vx
        cdef bool[:] vderiv

        n = len(lam)

        I = np.empty(n-1, dtype=np.double)

        vx, vderiv = self._vector_args(dx, deriv)

        interp_specgrid_intensity(self.specgrid, &vx[0], mu, n, &lam[0],
                                  &I[0], &stat, &vderiv[0])

        if stat != STAT_OK:
            handle_error(stat)

        return np.asarray(I)

    
    def E_moment(self, dict dx, int k, double[:] lam, dict deriv=None):
        r"""Evaluate the spectroscopic intensity E-moment.

        Args:
            dx (dict): Atmospheric parameters; keys must match
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
            KeyError: If `dx` does not define all keys appearing in the
                `axis_labels` property.
            ValueError: If `dx`, `k`, or any part of the wavelength
                abscissa falls outside the bounds of the grid.
            LookupError: If `dx` falls in a grid void.
        """

        cdef double[:] E
        cdef int stat
        cdef double[:] vx
        cdef bool[:] vderiv

        n = len(lam)

        E = np.empty(n-1, dtype=np.double)

        vx, vderiv = self._vector_args(dx, deriv)

        interp_specgrid_d_moment(self.specgrid, &vx[0], k, n, &lam[0], &E[0],
                                 &stat, &vderiv[0])

        if stat != STAT_OK:
            handle_error(stat)

        return np.asarray(E)

    
    def D_moment(self, dict dx, int l, double[:] lam, dict deriv=None):
        r"""Evaluate the spectroscopic intensity D-moment.

        Args:
            dx (dict): Atmospheric parameters; keys must match
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
            KeyError: If `dx` does not define all keys appearing in the
                `axis_labels` property.
            ValueError: If `dx`, `l`, or any part of the wavelength
                abscissa falls outside the bounds of the grid.
            LookupError: If `dx` falls in a grid void.
        """

        cdef double[:] D
        cdef int stat
        cdef double[:] vx
        cdef bool[:] vderiv

        n = len(lam)

        D = np.empty(n-1, dtype=np.double)

        vx, vderiv = self._vector_args(dx, deriv)

        interp_specgrid_e_moment(self.specgrid, &vx[0], l, n, &lam[0], &D[0],
                                 &stat, &vderiv[0])

        if stat != STAT_OK:
            handle_error(stat)

        return np.asarray(D)

    
    def flux(self, dict dx, double[:] lam, dict deriv=None):
        r"""Evaluate the spectroscopic flux.

        Args:
            dx (dict): Atmospheric parameters; keys must match
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
            KeyError: If `dx` does not define all keys appearing in the
                `axis_labels` property.
            ValueError: If `dx` or any part of the wavelength abscissa 
                falls outside the bounds of the grid.
            LookupError: If `dx` falls in a grid void.
        """

        cdef double[:] F
        cdef int stat
        cdef double[:] vx
        cdef bool[:] vderiv

        n = len(lam)

        F = np.empty(n-1, dtype=np.double)

        vx, vderiv = self._vector_args(dx, deriv)

        interp_specgrid_flux(self.specgrid, &vx[0], n, &lam[0], &F[0], &stat,
                             &vderiv[0])
        if stat != STAT_OK:
            handle_error(stat)
        
        return np.asarray(F)


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

        if stat != STAT_OK:
            handle_error(stat)

        get_photgrid_rank(&self.photgrid, &self.rank)

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

        
    def _vector_args(self, dx, deriv):

        vx = np.array([dx[key] for key in self.axis_labels])

        if deriv is not None:
            vderiv = np.array([key in deriv for key in self.axis_labels],
                              dtype=np.uint8)
        else:
            vderiv = np.array([False]*self.rank, dtype=np.uint8)

        return vx, vderiv
    
        
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
        if stat != STAT_OK:
            handle_error(stat)


    def intensity(self, dict dx, double mu, dict deriv=None):
        r"""Evaluate the photometric intensity, normalized to the zero-
            point flux.

        Args:
            dx (dict): Atmospheric parameters; keys must match 
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
            KeyError: If `dx` does not define all keys appearing in the
                `axis_labels` property.
            ValueError: If `dx` or `mu` falls outside the bounds of the 
                grid.
            LookupError: If `dx` falls in a grid void.
        """

        cdef double I
        cdef int stat
        cdef double[:] vx
        cdef bool[:] vderiv

        vx, vderiv = self._vector_args(dx, deriv)

        interp_photgrid_intensity(self.photgrid, &vx[0], mu, &I, &stat,
                                  &vderiv[0])
        if stat != STAT_OK:
            handle_error(stat)

        return I

    
    def E_moment(self, dict dx, int k, dict deriv=None):
        r"""Evaluate the photometric intensity E-moment, normalized to
            the zero-point flux.

        Args:
            dx (dict): Atmospheric parameters; keys must match
                `axis_labels` property, values must be double.
            k (int): Degree of moment.
            deriv (dict, optional): Flags indicating whether to evaluate 
                derivative with respect to each atmospheric parameter; 
                keys must match the `axis_labels` property, values must 
                be boolean.

        Returns:
            double: photometric intensity E-moment.

        Raises:
            KeyError: If `dx` does not define all keys appearing in the
                `axis_labels` property.
            ValueError: If `dx` or `k` falls outside the bounds of the 
                grid.
            LookupError: If `dx` falls in a grid void.
       """

        cdef double E
        cdef int stat
        cdef double[:] vx
        cdef bool[:] vderiv

        vx, vderiv = self._vector_args(dx, deriv)

        interp_photgrid_e_moment(self.photgrid, &vx[0], k, &E, &stat,
                                 &vderiv[0])
        if stat != STAT_OK:
            handle_error(stat)

        return E

    
    def D_moment(self, dict dx, int l, dict deriv=None):
        r"""Evaluate the photometric intensity D-moment, normalized to
            the zero-point flux.

        Args:
            dx (dict): Atmospheric parameters; keys must match
                `axis_labels` property, values must be double.
            l (int): Harmonic degree of moment.
            deriv (dict, optional): Flags indicating whether to evaluate 
                derivative with respect to each atmospheric parameter; 
                keys must match the `axis_labels` property, values must 
                be boolean.

        Returns:
            double: photometric intensity D-moment.

        Raises:
            KeyError: If `dx` does not define all keys appearing in the
                `axis_labels` property.
            ValueError: If `dx` or `l` falls outside the bounds of the 
                grid.
            LookupError: If `dx` falls in a grid void.
       """

        cdef double D
        cdef int stat
        cdef double[:] vx
        cdef bool[:] vderiv

        vx, vderiv = self._vector_args(dx, deriv)

        interp_photgrid_d_moment(self.photgrid, &vx[0], l, &D, &stat,
                                 &vderiv[0])
        if stat != STAT_OK:
            handle_error(stat)

        return D

    
    def flux(self, dict dx, dict deriv=None):
        r"""Evaluate the photometric flux, normalized to the zero-point
            flux.

        Args:
            dx (dict): Atmospheric parameters; keys must match
                `axis_labels` property, values must be double.
            deriv (dict, optional): Flags indicating whether to evaluate 
                derivative with respect to each atmospheric parameter; 
                keys must match the `axis_labels` property, values must 
                be boolean.

        Returns:
            double: photometric flux.

        Raises:
            KeyError: If `dx` does not define all keys appearing in the
                `axis_labels` property.
            ValueError: If `dx` or `l` falls outside the bounds of the 
                grid.
            LookupError: If `dx` falls in a grid void.
       """

        cdef double F
        cdef int stat
        cdef double[:] vx
        cdef bool[:] vderiv

        vx, vderiv = self._vector_args(dx, deriv)

        interp_photgrid_flux(self.photgrid, &vx[0], &F, &stat, &vderiv[0])

        if stat != STAT_OK:
            handle_error(stat)

        return F


def handle_error(stat):

    # Use the stat value to throw an appropriate exception

    if stat == STAT_OUT_OF_BOUNDS_AXIS_LO:
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
    elif stat == STAT_INVALID_TYPE:
        raise TypeError('invalid type')
    elif stat == STAT_FILE_NOT_FOUND:
        raise FileNotFoundError('file not found')
    else:
        raise Exception(f'error with unknown stat code: {stat}')
