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
cimport numpy as cnp
cimport cython

from libcpp cimport bool

cdef extern from "cmsg.h":

    void *specgrid_load(const char *filename)
    void specgrid_unload(void *ptr)
    void specgrid_inquire(void *ptr, double *lam_min, double *lam_max, int shape[], int *rank, double axis_min[], double axis_max[])
    void specgrid_get_axis_label(void *ptr, int i, char *axis_label)
    void specgrid_interp_intensity(void *ptr, double *vx, double mu, int n, double lam[], double I[], int *stat, bool *vderiv)
    void specgrid_interp_d_moment(void *ptr, double *vx, int l, int n, double lam[], double D[], int *stat, bool *vderiv)
    void specgrid_interp_flux(void *ptr, double *vx, int n, double lam[], double F[], int *stat, bool *vderiv)

    void *photgrid_load(const char *filename)
    void photgrid_unload(void *ptr)
    void photgrid_inquire(void *ptr, int shape[], int *rank, double axis_min[], double axis_max[])
    void photgrid_get_axis_label(void *ptr, int i, char *axis_label)
    void photgrid_interp_intensity(void *ptr, double *vx, double mu, double *I, int *stat, bool *vderiv)
    void photgrid_interp_d_moment(void *ptr, double *vx, int l, double *D, int *stat, bool *vderiv)
    void photgrid_interp_flux(void *ptr, double *vx, double *F, int *stat, bool *vderiv)


@cython.binding(True)
cdef class SpecGrid:
    r"""A SpecGrid represents a grid of spectral intensity data.

    This grid may be used to interpolate the specific intensity (or
    related quantities) across a wavelength abscissa and for
    a set of atmospheric parameter values.

    """

    cdef void *ptr
    
    cdef readonly double lam_min
    """double: Wavelength abscissa minimum value."""
    cdef readonly double lam_max
    """double: Wavelength abscissa maxmimum value."""
    cdef readonly int rank
    """int: Number of atmospheric parameters axes."""
    cdef readonly list axis_labels
    """list: Atmospheric parameter axes labels."""
    
    cdef int[:] _shape
    cdef double[:] _axis_min
    cdef double[:] _axis_max

    def __init__(self, str filename):
        """SpecGrid constructor.

        Args:
            filename (string): Full pathname of grid file to load.
        """

        self.ptr = specgrid_load(filename.encode('ascii'))

        specgrid_inquire(self.ptr, &self.lam_min, &self.lam_max, NULL, &self.rank, NULL, NULL)

        self._shape = np.empty(self.rank, dtype=np.intc)
        self._axis_min = np.empty(self.rank, dtype=np.double)
        self._axis_max = np.empty(self.rank, dtype=np.double)
        
        specgrid_inquire(self.ptr, NULL, NULL, &self._shape[0], NULL, &self._axis_min[0], &self._axis_max[0])

        self.axis_labels = []
        cdef char axis_label[17]
        for j in range(self.rank):
            specgrid_get_axis_label(self.ptr, j+1, axis_label)
            self.axis_labels += [axis_label.decode('ascii')]

        
    def __dealloc__(self):

        specgrid_unload(self.ptr)


    def _vector_args(self, dx, deriv):

        vx = np.array([dx[key] for key in self.axis_labels])

        if deriv is not None:
            vderiv = np.array([key in deriv for key in self.axis_labels], dtype=np.uint8)
        else:
            vderiv = np.array([False]*self.rank, dtype=np.uint8)

        return vx, vderiv

    
    @property
    def shape(self):
        """numpy.ndarray: Atmospheric parameter axes lengths."""
        return np.asarray(self._shape)

    
    @property
    def axis_min(self):
        """numpy.ndarray: Atmospheric parameter axes minimia."""
        return np.asarray(self._axis_min)

    
    @property
    def axis_max(self):
        """numpy.ndarray: Atmospheric parameter axes max."""
        return np.asarray(self._axis_max)

    
    def intensity(self, dict dx, double mu, double[:] lam, dict deriv=None):
        r"""Evaluate the spectroscopic intensity :math:`I(\mu,lam)`.

        Args:
            dx (dict): Atmospheric parameters; keys must match
                `axis_labels` property, values must be double.
            mu (double): Cosine of angle of emergence, :math:`\mu`, 
                relative to surface normal.
            lam[] (double): Wavelength abscissa.
            deriv (dict, optional): Flags indicating whether to 
                evaluate derivative wrt each atmospheric parameter;
                keys must match the `axis_labels` property, values must 
                be boolean.

        Returns:
            numpy.ndarray: spectroscopic intensity

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

        specgrid_interp_intensity(self.ptr, &vx[0], mu, n, &lam[0], &I[0], &stat, &vderiv[0])

        if stat != 0:
            handle_error(stat)

        return np.asarray(I)

    
    def D_moment(self, dict dx, int l, double[:] lam, dict deriv=None):
        r"""Evaluate the spectroscopic intensity moment :math:`D_{\ell}(w)`.

        Args:
            dx (dict): Atmospheric parameters; keys must match
                `axis_labels` property, values must be double.
            l (int): Harmonic degree of moment.
            lam[] (doubley): Wavelength abscissa.
            deriv (dict, optional): Flags indicating whether to 
                evaluate derivative wrt each atmospheric parameter;
                keys must match the `axis_labels` property, values must 
                be boolean.

        Returns:
            numpy.ndarray: spectroscopic intensity moment.

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

        specgrid_interp_d_moment(self.ptr, &vx[0], l, n, &lam[0], &D[0], &stat, &vderiv[0])

        if stat != 0:
            handle_error(stat)

        return np.asarray(D)

    
    def flux(self, dict dx, double[:] lam, dict deriv=None):
        r"""Evaluate the spectroscopic flux :math:`F(w)`.

        Args:
            dx (dict): Atmospheric parameters; keys must match
                `axis_labels` property, values must be double.
            lam[] (double): Wavelength abscissa.
            deriv (dict, optional): Flags indicating whether to 
                evaluate derivative wrt each atmospheric parameter;
                keys must match the `axis_labels` property, values must
                be boolean.

        Returns:
            numpy.ndarray: spectroscopic flux.

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

        specgrid_interp_flux(self.ptr, &vx[0], n, &lam[0], &F[0], &stat, &vderiv[0])
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
    
    cdef int[:] _shape
    cdef double[:] _axis_min
    cdef double[:] _axis_max

    def __init__(self, str filename):
        """PhotGrid constructor.

        Args:
            filename (string): Full pathname of grid file to load.
        """

        self.ptr = photgrid_load(filename.encode('ascii'))

        photgrid_inquire(self.ptr, NULL, &self.rank, NULL, NULL)

        self._shape = np.empty(self.rank, dtype=np.intc)
        self._axis_min = np.empty(self.rank, dtype=np.double)
        self._axis_max = np.empty(self.rank, dtype=np.double)

        photgrid_inquire(self.ptr, &self._shape[0], NULL, &self._axis_min[0], &self._axis_max[0])

        self.axis_labels = []
        cdef char axis_label[17]
        for j in range(self.rank):
            photgrid_get_axis_label(self.ptr, j+1, axis_label)
            self.axis_labels += [axis_label.decode('ascii')]

        
    def __dealloc__(self):
        
        photgrid_unload(self.ptr)

        
    def _vector_args(self, dx, deriv):

        vx = np.array([dx[key] for key in self.axis_labels])

        if deriv is not None:
            vderiv = np.array([key in deriv for key in self.axis_labels], dtype=np.uint8)
        else:
            vderiv = np.array([False]*self.rank, dtype=np.uint8)

        return vx, vderiv
    
        
    @property
    def shape(self):
        """numpy.ndarray: Atmospheric parameter axes lengths."""
        return np.asarray(self._shape)

    
    @property
    def axis_min(self):
        """numpy.ndarray: Atmospheric parameter axes minimia."""
        return np.asarray(self._axis_min)

    
    @property
    def axis_max(self):
        """numpy.ndarray: Atmospheric parameter axes max."""
        return np.asarray(self._axis_max)

    
    def intensity(self, dict dx, double mu, dict deriv=None):
        r"""Evaluate the photometric intensity :math:`I_{x}(\mu)`.

        Args:
            dx (dict): Atmospheric parameters; keys must match
                the `axis_labels` property, values must be double.
            mu (double): Cosine of angle of emergence, :math:`\mu`, 
                relative to surface normal.
            deriv (dict, optional): Flags indicating whether to 
                evaluate derivative wrt each atmospheric parameter;
                keys must match the `axis_labels` property, values must
                be boolean.

        Returns:
            double: photometric intensity

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

        photgrid_interp_intensity(self.ptr, &vx[0], mu, &I, &stat,  &vderiv[0])
        if stat != 0:
            handle_error(stat)

        return I

    
    def D_moment(self, dict dx, int l, dict deriv=None):
        r"""Evaluate the photometric intensity moment :math:`D_{\ell,x}`.

        Args:
            dx (dict): Atmospheric parameters; keys must match
                axis_labels property, values must be double.
            l (int): Harmonic degree of Legendre function :math:`P_{\ell}`.
            deriv (dict, optional): Flags indicating whether to 
                evaluate derivative wrt each atmospheric parameter;
                keys must match axis_labels property, values must be 
                boolean.

        Returns:
            double: photometric intensity moment.

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

        photgrid_interp_d_moment(self.ptr, &vx[0], l, &D, &stat, &vderiv[0])
        if stat != 0:
            handle_error(stat)

        return D

    
    def flux(self, dict dx, dict deriv=None):
        r"""Evaluate the photometric flux :math:`F_{x}`.

        Args:
            dx (dict): Atmospheric parameters; keys must match
                axis_labels property, values must be double.
            deriv (dict, optional): Flags indicating whether to 
                evaluate derivative wrt each atmospheric parameter;
                keys must match axis_labels property, values must be 
                boolean.

        Returns:
            double: photometric flux.

        Raises:
            KeyError: If `dx` does not define all keys appearing in the
                `axis_labels` property.
            ValueError: If `dx` falls outside the bounds of the grid.
            LookupError: If `dx` falls in a grid void.
       """

        cdef double F
        cdef int stat
        cdef double[:] vx
        cdef bool[:] vderiv

        vx, vderiv = self._vector_args(dx, deriv)

        photgrid_interp_flux(self.ptr, &vx[0], &F, &stat, &vderiv[0])
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
    else:
        raise Exception(f'error with unknown stat code: {stat}')
    
