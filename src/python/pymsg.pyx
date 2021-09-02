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
    void *specgrid_load_rebin(const char *filename, double w_0, double dw, int n_w)
    void specgrid_unload(void *ptr)
    void specgrid_inquire(void *ptr, double *w_0, double *n_w, int *dw, int shape[], int *rank, double axis_min[], double axis_max[])
    void specgrid_get_axis_label(void *ptr, int i, char *axis_label)
    void specgrid_interp_intensity(void *ptr, double *vx, double mu, double w_0, int n_w, double I[], int *stat, bool *vderiv)
    void specgrid_interp_d_moment(void *ptr, double *vx, int l, double w_0, int n_w, double D[], int *stat, bool *vderiv)
    void specgrid_interp_flux(void *ptr, double *vx, double w_0, int n_w, double F[], int *stat, bool *vderiv)

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
    related quantities) across a spatial (wavelength) abscissa and for
    a set of atmospheric parameter values Both internally and for
    interpolated results, the spatial abscissa is configured as a set
    of bins distributed uniformly in :math:`w`-space, where
    :math:`{\rm d}w`, where :math:`w \equiv
    \log(\lambda/\angstrom)`. Three parameters uniquely specify the
    abscissa: w_0, dw and n_w; the i'th bin (i=0,...,n_w-1) then spans
    the interval [w_0+i*dw, w_0+(i+1)*dw].

    """

    cdef void *ptr
    
    cdef readonly double w_0
    """double: Spatial abscissa minimum value."""
    cdef readonly double dw
    """double: Spatial abscissa bin width."""
    cdef readonly int n_w
    """int: Spatial abscissa number of bins."""
    cdef readonly int rank
    """int: Number of atmospheric parameters axes"""
    cdef readonly list axis_labels
    """list: Atmospheric parameter axes labels."""
    
    cdef int[:] _shape
    cdef double[:] _axis_minima
    cdef double[:] _axis_maxima

    def __init__(self, str filename, tuple rebin_pars=None):
        """SpecGrid constructor.

        Args:
            filename (string): Full pathname of grid file to load.
            rebin_pars (tuple, optional): Parameters `(w_0, dw, n_w)` for
                rebinning grid data when loading.
        """

        if rebin_pars:
            w_0, dw, n_w = rebin_pars
            self.ptr = specgrid_load_rebin(filename.encode('ascii'), w_0, dw, n_w)
        else:
            self.ptr = specgrid_load(filename.encode('ascii'))

        specgrid_inquire(self.ptr, &self.w_0, &self.dw, &self.n_w, NULL, &self.rank, NULL, NULL)

        self._shape = np.empty(self.rank, dtype=np.intc)
        self._axis_minima = np.empty(self.rank, dtype=np.double)
        self._axis_maxima = np.empty(self.rank, dtype=np.double)
        
        specgrid_inquire(self.ptr, &self.w_0, &self.dw, &self.n_w, &self._shape[0], NULL, &self._axis_minima[0], &self._axis_maxima[0])

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
    def axis_minima(self):
        """numpy.ndarray: Atmospheric parameter axes minimia."""
        return np.asarray(self._axis_minima)

    
    @property
    def axis_maxima(self):
        """numpy.ndarray: Atmospheric parameter axes maxima."""
        return np.asarray(self._axis_maxima)

    
    def intensity(self, dict dx, double mu, double w_0, int n_w, dict deriv=None):
        r"""Evaluate the spectroscopic intensity :math:`I(\mu,w)`.

        Args:
            dx (dict): Atmospheric parameters; keys must match
                `axis_labels` property, values must be double.
            mu (double): Cosine of angle of emergence, :math:`\mu`, 
                relative to surface normal.
            w_0 (double): Spatial abscissa minimum value.
            n_w (int): Spatial abscissa number of bins.
            deriv (dict, optional): Flags indicating whether to 
                evaluate derivative wrt each atmospheric parameter;
                keys must match the `axis_labels` property, values must 
                be boolean.

        Returns:
            numpy.ndarray: spectroscopic intensity [:math:`\erg\,\cm^{-2}\,\second^{-1}\,\steradian^{-1}`]

        Raises:
            KeyError: If `dx` does not define all keys appearing in the
                `axis_labels` property.
            ValueError: If `dx`, `mu`, or any part of the spatial 
                abscissa falls outside the bounds of the grid.
            LookupError: If `dx` falls in a grid void.

        Note:
            The spatial abscissa for the returned data is defined by
            the `w_0` and `n_w` parameters, and the `dw` property.
        """

        cdef double[:] I
        cdef int stat
        cdef double[:] vx
        cdef bool[:] vderiv

        I = np.empty(n_w, dtype=np.double)

        vx, vderiv = self._vector_args(dx, deriv)

        specgrid_interp_intensity(self.ptr, &vx[0], mu, w_0, n_w, &I[0], &stat, &vderiv[0])

        if stat != 0:
            handle_error(stat)

        return np.asarray(I)

    
    def D_moment(self, dict dx, int l, double w_0, int n_w, dict deriv=None):
        r"""Evaluate the spectroscopic intensity moment :math:`D_{\ell}(w)`.

        Args:
            dx (dict): Atmospheric parameters; keys must match
                `axis_labels` property, values must be double.
            l (int): Harmonic degree of moment.
            w_0 (double): Spatial abscissa minimum value.
            n_w (int): Spatial abscissa number of bins.
            deriv (dict, optional): Flags indicating whether to 
                evaluate derivative wrt each atmospheric parameter;
                keys must match the `axis_labels` property, values must 
                be boolean.

        Returns:
            numpy.ndarray: spectroscopic intensity moment [:math:`\erg\,\cm^{-2}\,\second^{-1}`]

        Raises:
            KeyError: If `dx` does not define all keys appearing in the
                `axis_labels` property.
            ValueError: If `dx`, `l`, or any part of the spatial 
                abscissa falls outside the bounds of the grid.
            LookupError: If `dx` falls in a grid void.

        Note:
            The spatial abscissa for the returned data is defined by
            the `w_0` and `n_w` parameters, and the `dw` property.
        """

        cdef double[:] D
        cdef int stat
        cdef double[:] vx
        cdef bool[:] vderiv

        D = np.empty(n_w, dtype=np.double)

        vx, vderiv = self._vector_args(dx, deriv)

        specgrid_interp_d_moment(self.ptr, &vx[0], l, w_0, n_w, &D[0], &stat, &vderiv[0])

        if stat != 0:
            handle_error(stat)

        return np.asarray(D)

    
    def flux(self, dict dx, double w_0, int n_w, dict deriv=None):
        r"""Evaluate the spectroscopic flux :math:`F(w)`.

        Args:
            dx (dict): Atmospheric parameters; keys must match
                `axis_labels` property, values must be double.
            w_0 (double): Spatial abscissa minimum value.
            n_w (int): Spatial abscissa number of bins.
            deriv (dict, optional): Flags indicating whether to 
                evaluate derivative wrt each atmospheric parameter;
                keys must match the `axis_labels` property, values must
                be boolean.

        Returns:
            numpy.ndarray: spectroscopic flux [:math:`\erg\,\cm^{-2}\,\second^{-1}`]

        Raises:
            KeyError: If `dx` does not define all keys appearing in the
                `axis_labels` property.
            ValueError: If `dx` or any part of the spatial abscissa 
                falls outside the bounds of the grid.
            LookupError: If `dx` falls in a grid void.

        Note:
            The spatial abscissa for the returned data is defined by
            the `w_0` and `n_w` parameters, and the `dw` property.
        """

        cdef double[:] F
        cdef int stat
        cdef double[:] vx
        cdef bool[:] vderiv

        F = np.empty(n_w, dtype=np.double)

        vx, vderiv = self._vector_args(dx, deriv)

        specgrid_interp_flux(self.ptr, &vx[0], w_0, n_w, &F[0], &stat, &vderiv[0])
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
    cdef double[:] _axis_minima
    cdef double[:] _axis_maxima

    def __init__(self, str filename):
        """PhotGrid constructor.

        Args:
            filename (string): Full pathname of grid file to load.
        """

        self.ptr = photgrid_load(filename.encode('ascii'))

        photgrid_inquire(self.ptr, NULL, &self.rank, NULL, NULL)

        self._shape = np.empty(self.rank, dtype=np.intc)
        self._axis_minima = np.empty(self.rank, dtype=np.double)
        self._axis_maxima = np.empty(self.rank, dtype=np.double)

        photgrid_inquire(self.ptr, &self._shape[0], NULL, &self._axis_minima[0], &self._axis_maxima[0])

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
    def axis_minima(self):
        """numpy.ndarray: Atmospheric parameter axes minimia."""
        return np.asarray(self._axis_minima)

    
    @property
    def axis_maxima(self):
        """numpy.ndarray: Atmospheric parameter axes maxima."""
        return np.asarray(self._axis_maxima)

    
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
            double: photometric intensity [:math:`\erg\,\cm^{-2}\,\second^{-1}\,\steradian^{-1}`]

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
            double: photometric intensity moment [:math:`\erg\,\cm^{-2}\,\second^{-1}`]

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
            double: Photometric flux [:math:`\erg\,\cm^{-2}\,\second^{-1}`]

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
        raise ValueError('out-of-bounds (lo) w')
    elif stat == 4:
        raise ValueError('out-of-bounds (hi) w')
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
    
