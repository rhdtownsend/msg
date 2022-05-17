#python: language_level=3
#
# Module  : pymsg.specgrid
# Purpose : MSG Python interface (specgrid part)
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
import pymsg.pycmsg as pyc

# Class definition

class SpecGrid:
    r"""The SpecGrid class represents a grid of spectroscopic intensity data.

    This grid may be used to interpolate the intensity (or related
    quantities) across a wavelength abscissa and for a set of
    atmospheric parameter values.

    """

    def __init__(self, filename):
        """SpecGrid constructor.

        Args:
            filename (string): Filename of grid to load.

        Returns:
            pymsg.SpecGrid: Constructed object.

        Raises:
            FileNotFound: If the the file cannot be found.
            TypeError: If the file contains an incorrect datatype.
        """

        self._specgrid = pyc._load_specgrid(filename)

        self._rank = pyc._get_specgrid_rank(self._specgrid)

        self._axis_labels = []
        self._axis_x_min = {}
        self._axis_x_max = {}

        for i in range(self._rank):

            axis_label = pyc._get_specgrid_axis_label(self._specgrid, i)

            self._axis_labels += [axis_label]
            self._axis_x_min[axis_label] = pyc._get_specgrid_axis_x_min(self._specgrid, i)
            self._axis_x_max[axis_label] = pyc._get_specgrid_axis_x_max(self._specgrid, i)

        
    def __dealloc__(self):

        pyc._unload_specgrid(self._specgrid)

        self._specgrid = None


    def _vector_args(self, x, deriv):

        x_vec = np.array([x[key] for key in self._axis_labels])

        if deriv is not None:
            deriv_vec = np.array([key in deriv for key in self._axis_labels],
                                 dtype=np.uint8)
        else:
            deriv_vec = np.array([False]*self.rank, dtype=np.uint8)

        return x_vec, deriv_vec

    
    @property
    def rank(self):
        """int: Number of dimensions in grid."""
        return self._rank

    
    @property
    def axis_labels(self):
        """list: Atmospheric parameter axis labels."""
        return self._axis_labels

    
    @property
    def axis_x_min(self):
        """dict: Atmospheric parameter axis minima."""
        return self._axis_x_min

    
    @property
    def axis_x_max(self):
        """dict: Atmospheric parameter axis maxima."""
        return self._axis_x_max

    
    @property
    def lam_min(self):
        """double: Minimum wavelength of grid."""
        return pyc._get_specgrid_lam_min(self._specgrid)

    
    @property
    def lam_max(self):
        """double: Maximum wavelength of grid."""
        return pyc._get_specgrid_cache_lam_max(self._specgrid)


    @property
    def cache_lam_min(self):
        """double: Minimum wavelength of grid cache."""
        return pyc._get_specgrid_cache_lam_min(self._specgrid)
    @cache_lam_min.setter
    def cache_lam_min(self, cache_lam_min):
        pyc._set_specgrid_cache_lam_min(self._specgrid, cache_lam_min)


    @property
    def cache_lam_max(self):
        """double: Maximum wavelength of grid cache."""
        return pyc._get_specgrid_cache_lam_max(self._specgrid)
    @cache_lam_max.setter
    def cache_lam_max(self, cache_lam_max):
        pyc.set_specgrid_cache_lam_max(self._specgrid, cache_lam_max)
        

    @property
    def cache_count(self):
        """int: Number of nodes currently held in grid cache."""
        return pyc._get_specgrid_cache_count(self._specgrid)


    @property
    def cache_limit(self):
        """double: Maximum number of nodes to hold in grid cache. Set to 0 to disable 
           caching."""
        return pyc._get_specgrid_cache_limit(self._specgrid)
    @cache_limit.setter
    def cache_limit(self, cache_limit):
        pyc._set_specgrid_cache_limit(self._specgrid, limit)


    def intensity(self, x, mu, lam, deriv=None):
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

        x_vec, deriv_vec = self._vector_args(x, deriv)

        return pyc._interp_specgrid_intensity(self._specgrid, x_vec, mu, lam,
                                              deriv_vec)

    
    def E_moment(self, x, k, lam, deriv=None):
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

        x_vec, deriv_vec = self._vector_args(x, deriv)

        return pyc._interp_specgrid_E_moment(self._specgrid, x_vec, k, lam,
                                             deriv_vec)

    
    def D_moment(self, x, l, lam, deriv=None):
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

        x_vec, deriv_vec = self._vector_args(x, deriv)

        return pyc._interp_specgrid_D_moment(self._specgrid, x_vec, l, lam,
                                             deriv_vec)

    
    def flux(self, x, lam, deriv=None):
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

        x_vec, deriv_vec = self._vector_args(x, deriv)

        print('x_vec, deriv_vec', x_vec, deriv_vec)

        return pyc._interp_specgrid_flux(self._specgrid, x_vec, lam,
                                         deriv_vec)
