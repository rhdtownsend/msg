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

cdef extern from "cmsg.h":

    void c_load_specgrid(const char *filename, void **ptr, int *stat)
    void c_unload_specgrid(void *ptr)
    void c_inquire_specgrid(void *ptr, double *lam_min, double *lam_max,
                            int shape[], int *rank, double axis_min[],
                            double axis_max[])
    void c_get_axis_label_specgrid(void *ptr, int i, char *axis_label)
    void c_interp_intensity_specgrid(void *ptr, double *vx, double mu,
                                     int n, double lam[], double I[],
                                     int *stat, bool *vderiv)
    void c_interp_d_moment_specgrid(void *ptr, double *vx, int l, int n,
                                    double lam[], double D[], int *stat,
                                    bool *vderiv)
    void c_interp_flux_specgrid(void *ptr, double *vx, int n, double lam[],
                                double F[], int *stat, bool *vderiv)

    void c_load_photgrid(const char *filename, void **ptr, int *stat)
    void c_load_photgrid_from_specgrid(const char *specgrid_filename,
                                       const char *passband_filename,
                                       void **ptr, int *stat)
    void c_unload_photgrid(void *ptr)
    void c_inquire_photgrid(void *ptr, int shape[], int *rank,
                            double axis_min[], double axis_max[])
    void c_get_axis_label_photgrid(void *ptr, int i, char *axis_label)
    void c_interp_intensity_photgrid(void *ptr, double *vx, double mu,
                                     double *I, int *stat, bool *vderiv)
    void c_interp_d_moment_photgrid(void *ptr, double *vx, int l,
                                    double *D, int *stat, bool *vderiv)
    void c_interp_flux_photgrid(void *ptr, double *vx, double *F,
                                int *stat, bool *vderiv)


@cython.binding(True)
cdef class SpecGrid:
    r"""A SpecGrid represents a grid of spectral intensity data.

    This grid may be used to interpolate the specific intensity (or
    related quantities) across a wavelength abscissa and for a set of
    atmospheric parameter values.

    """

    cdef void *ptr
    
    cdef readonly double lam_min
    """double: Wavelength abscissa minimum."""
    cdef readonly double lam_max
    """double: Wavelength abscissa maxmimum."""
    cdef readonly int rank
    """int: Number of atmospheric parameters."""
    cdef readonly list axis_labels
    """list: Atmospheric parameter axis labels."""
    cdef readonly dict axis_min
    """dict: Atmospheric parameter axis minima."""
    cdef readonly dict axis_max
    """dict: Atmospheric parameter axis maxima."""
    
    cdef int[:] _shape
    
    def __init__(self, str filename):
        """SpecGrid constructor.

        Args:
            filename (string): Filename of grid to load. If the file does
                not exist, MSG will prepend MSG_DIR/data/ to the filename
                and try again.
        Raises:
            FileNotFound: If the the file cannot be found.
            TypeError: If the file contains an incorrect datatype.
        """

        cdef int stat
        cdef double[:] axis_min_vals
        cdef double[:] axis_max_vals

        c_load_specgrid(filename.encode('ascii'), &self.ptr, &stat)

        if stat != 0:
            handle_error(stat)

        c_inquire_specgrid(self.ptr, &self.lam_min, &self.lam_max, NULL,
                           &self.rank, NULL, NULL)

        self._shape = np.empty(self.rank, dtype=np.intc)

        axis_min_vals = np.empty(self.rank, dtype=np.double)
        axis_max_vals = np.empty(self.rank, dtype=np.double)
        
        c_inquire_specgrid(self.ptr, NULL, NULL, &self._shape[0], NULL,
                           &axis_min_vals[0], &axis_max_vals[0])

        self.axis_labels = []
        cdef char axis_label[17]
        for j in range(self.rank):
            c_get_axis_label_specgrid(self.ptr, j+1, axis_label)
            self.axis_labels += [axis_label.decode('ascii')]

        self.axis_min = dict(zip(self.axis_labels, axis_min_vals))
        self.axis_max = dict(zip(self.axis_labels, axis_max_vals))

        
    def __dealloc__(self):

        c_unload_specgrid(self.ptr)


    def _vector_args(self, dx, deriv):

        vx = np.array([dx[key] for key in self.axis_labels])

        if deriv is not None:
            vderiv = np.array([key in deriv for key in self.axis_labels],
                              dtype=np.uint8)
        else:
            vderiv = np.array([False]*self.rank, dtype=np.uint8)

        return vx, vderiv

    
    @property
    def shape(self):
        """dict: Atmospheric parameter axes lengths."""
        return dict(zip(self.axis_labels, self._shape))

    
    def intensity(self, dict dx, double mu, double[:] lam,
                  dict deriv=None):
        r"""Evaluate the spectroscopic intensity.

        Args:
            dx (dict): Atmospheric parameters; keys must match 
                `axis_labels` property, values must be double.
            mu (double): Cosine of angle of emergence relative to 
                surface normal.
            lam (numpy.ndarray): Wavelength abscissa (Å).
            deriv (dict, optional): Flags indicating whether to evaluate 
                derivative with respect to each atmospheric parameter; 
                keys must match the `axis_labels` property, values must 
                be boolean.

        Returns:
            numpy.ndarray: spectroscopic intensity (erg/cm^2/s/Å/sr) in
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

        c_interp_intensity_specgrid(self.ptr, &vx[0], mu, n, &lam[0],
                                    &I[0], &stat, &vderiv[0])

        if stat != 0:
            handle_error(stat)

        return np.asarray(I)

    
    def D_moment(self, dict dx, int l, double[:] lam, dict deriv=None):
        r"""Evaluate the spectroscopic intensity moment.

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
            numpy.ndarray: spectroscopic intensity moment (erg/cm^2/s/Å) 
            in bins delineated by lam; length len(lam)-1.

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

        c_interp_d_moment_specgrid(self.ptr, &vx[0], l, n, &lam[0], &D[0],
                                   &stat, &vderiv[0])

        if stat != 0:
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
            numpy.ndarray: spectroscopic flux (erg/cm^2/s/Å) in bins 
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

        c_interp_flux_specgrid(self.ptr, &vx[0], n, &lam[0], &F[0], &stat,
                               &vderiv[0])
        if stat != 0:
            handle_error(stat)
        
        return np.asarray(F)


@cython.binding(True)
cdef class PhotGrid:
    r"""A PhotGrid represents a grid of photometric intensity data.

    This grid may be used to interpolate the photometric intensity (or
    related quantities) for a set of atmospheric parameter values.

    """

    cdef void *ptr
    
    cdef readonly int rank
    """int: Number of atmospheric parameter axes."""
    cdef readonly list axis_labels
    """list: Atmospheric parameter axes labels."""
    cdef readonly dict axis_min
    """dict: Atmospheric parameter axis minima."""
    cdef readonly dict axis_max
    """dict: Atmospheric parameter axis maxima."""

    cdef int[:] _shape

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
        cdef double[:] axis_min_vals
        cdef double[:] axis_max_vals

        if passband_filename is not None:
            c_load_photgrid_from_specgrid(filename.encode('ascii'),
                                          passband_filename.encode('ascii'),
                                          &self.ptr, &stat)
        else:
            c_load_photgrid(filename.encode('ascii'), &self.ptr, &stat)

        if stat != 0:
            handle_error(stat)

        c_inquire_photgrid(self.ptr, NULL, &self.rank, NULL, NULL)

        self._shape = np.empty(self.rank, dtype=np.intc)
        axis_min_vals = np.empty(self.rank, dtype=np.double)
        axis_max_vals = np.empty(self.rank, dtype=np.double)

        c_inquire_photgrid(self.ptr, &self._shape[0], NULL,
                           &axis_min_vals[0], &axis_max_vals[0])

        self.axis_labels = []
        cdef char axis_label[17]
        for j in range(self.rank):
            c_get_axis_label_photgrid(self.ptr, j+1, axis_label)
            self.axis_labels += [axis_label.decode('ascii')]

        self.axis_min = dict(zip(self.axis_labels, axis_min_vals))
        self.axis_max = dict(zip(self.axis_labels, axis_max_vals))

        
    def __dealloc__(self):
        
        c_unload_photgrid(self.ptr)

        
    def _vector_args(self, dx, deriv):

        vx = np.array([dx[key] for key in self.axis_labels])

        if deriv is not None:
            vderiv = np.array([key in deriv for key in self.axis_labels],
                              dtype=np.uint8)
        else:
            vderiv = np.array([False]*self.rank, dtype=np.uint8)

        return vx, vderiv
    
        
    @property
    def shape(self):
        """dict: Atmospheric parameter axes lengths."""
        return dict(zip(self.axis_labels, self._shape))

    
    def intensity(self, dict dx, double mu, dict deriv=None):
        r"""Evaluate the photometric intensity :math:`I_{x}(\mu)`.

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
            double: photometric intensity (erg/cm^2/s/sr).

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

        c_interp_intensity_photgrid(self.ptr, &vx[0], mu, &I, &stat,
                                    &vderiv[0])
        if stat != 0:
            handle_error(stat)

        return I

    
    def D_moment(self, dict dx, int l, dict deriv=None):
        r"""Evaluate the photometric intensity moment.

        Args:
            dx (dict): Atmospheric parameters; keys must match
                `axis_labels` property, values must be double.
            l (int): Harmonic degree of moment.
            deriv (dict, optional): Flags indicating whether to evaluate 
                derivative with respect to each atmospheric parameter; 
                keys must match the `axis_labels` property, values must 
                be boolean.

        Returns:
            double: photometric intensity moment (erg/cm^2/s).

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

        c_interp_d_moment_photgrid(self.ptr, &vx[0], l, &D, &stat,
                                   &vderiv[0])
        if stat != 0:
            handle_error(stat)

        return D

    
    def flux(self, dict dx, dict deriv=None):
        r"""Evaluate the photometric flux.

        Args:
            dx (dict): Atmospheric parameters; keys must match
                `axis_labels` property, values must be double.
            deriv (dict, optional): Flags indicating whether to evaluate 
                derivative with respect to each atmospheric parameter; 
                keys must match the `axis_labels` property, values must 
                be boolean.

        Returns:
            double: photometric flux (erg/cm^2/s).

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

        c_interp_flux_photgrid(self.ptr, &vx[0], &F, &stat, &vderiv[0])

        if stat != 0:
            handle_error(stat)

        return F


def handle_error(stat):

    # Use the stat value to throw an appropriate exception

    if stat == 1:
        raise ValueError('out-of-bounds (lo) axis')
    elif stat == 2:
        raise ValueError('out-of-bounds (hi) axis')
    elif stat == 3:
        raise ValueError('out-of-bounds (lo) lam')
    elif stat == 4:
        raise ValueError('out-of-bounds (hi) lam')
    elif stat == 5:
        raise ValueError('out-of-bounds (lo) mu')
    elif stat == 6:
        raise ValueError('out-of-bounds (hi) mu')
    elif stat == 7:
        raise ValueError('invalid l')
    elif stat == 8:
        raise LookupError('unavailable data')
    elif stat == 9:
        raise TypeError('invalid type')
    elif stat == 10:
        raise FileNotFoundError('file not found')
    else:
        raise Exception(f'error with unknown stat code: {stat}')
    
