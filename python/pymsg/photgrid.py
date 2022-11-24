#python: language_level=3
#
# Module  : pymsg.photgrid
# Purpose : MSG Python interface (photgrid part)
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
    
class PhotGrid:
    r"""The PhotGrid class represents a grid of photometric intensity data.

    This grid may be used to interpolate the intensity (or related
    quantities) for a set of atmosphere parameter values.

    """
    
    def __init__(self, file_name, passband_file_name=None):
        """PhotGrid constructor (via loading data from a `photgrid` file, or
           from a `specgrid` file together with a passband file).

        Args:
            file_name (string): Name of grid file.
            passband_file_name (string): Name of passband file (if 
               file_name corresponds to a specgrid file)

        Returns:
            pymsg.PhotGrid: Constructed object.

        Raises:
            FileNotFound: If either file cannot be found.
            TypeError: If either file contains an incorrect datatype.

        """

        if passband_file_name is not None:
            self._photgrid = pyc._load_photgrid_from_specgrid(file_name, passband_file_name)
        else:
            self._photgrid = pyc._load_photgrid(file_name)

        self._rank = pyc._get_photgrid_rank(self._photgrid)

        self._axis_labels = []
        self._axis_x_min = {}
        self._axis_x_max = {}

        for i in range(self._rank):

            axis_label = pyc._get_photgrid_axis_label(self._photgrid, i)

            self._axis_labels += [axis_label]
            self._axis_x_min[axis_label] = pyc._get_photgrid_axis_x_min(self._photgrid, i)
            self._axis_x_max[axis_label] = pyc._get_photgrid_axis_x_max(self._photgrid, i)

        
    def __dealloc__(self):
        
        unload_photgrid(self._photgrid)

        self._photgrid = None

        
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
        """list: Atmosphere parameter axis labels."""
        return self._axis_labels

    
    @property
    def axis_x_min(self):
        """dict: Atmosphere parameter axis minima."""
        return self._axis_x_min

    
    @property
    def axis_x_max(self):
        """dict: Atmosphere parameter axis maxima."""
        return self._axis_x_max

    
    @property
    def cache_usage(self):
        """int: Current memory usage of grid cache (MB)."""
        return pyc._get_photgrid_cache_usage(self._photgrid)


    @property
    def cache_limit(self):
        """int: Maximum memory usage of grid cache (MB)."""
        return pyc._get_photgrid_cache_limit(self._photgrid)
    @cache_limit.setter
    def cache_limit(self, cache_limit):
        pyc._set_photgrid_cache_limit(self._photgrid, limit)


    def flush_cache(self):
        """Flush the grid cache"""
        pyc._flush_photgrid_cache(self._photgrid)


    def intensity(self, x, mu, deriv=None):
        r"""Evaluate the photometric intensity, normalized to the zero-
        point flux.

        Args:
            x (dict): Atmosphere parameters; keys must match 
                `axis_labels` property, values must be double.
            mu (double): Cosine of angle of emergence relative to 
                surface normal.
            deriv (dict, optional): Flags indicating whether to evaluate 
                derivative with respect to each atmosphere parameter; 
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

        x_vec, deriv_vec = self._vector_args(x, deriv)

        return pyc._interp_photgrid_intensity(self._photgrid, x_vec, mu, deriv_vec)

    
    def E_moment(self, x, k, deriv=None):
        r"""Evaluate the photometric intensity E-moment, normalized to
        the zero-point flux.

        Args:
            x (dict): Atmosphere parameters; keys must match
                `axis_labels` property, values must be double.
            k (int): Degree of moment.
            deriv (dict, optional): Flags indicating whether to evaluate 
                derivative with respect to each atmosphere parameter; 
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

        x_vec, deriv_vec = self._vector_args(x, deriv)

        return pyc._interp_photgrid_E_moment(self._photgrid, x_vec, k, deriv_vec)

    
    def D_moment(self, x, l, deriv=None):
        r"""Evaluate the photometric intensity D-moment, normalized to
        the zero-point flux.

        Args:
            x (dict): Atmosphere parameters; keys must match
                `axis_labels` property, values must be double.
            l (int): Harmonic degree of moment.
            deriv (dict, optional): Flags indicating whether to evaluate 
                derivative with respect to each atmosphere parameter; 
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

        x_vec, deriv_vec = self._vector_args(x, deriv)

        return pyc._interp_photgrid_D_moment(self._photgrid, x_vec, l, deriv_vec)

    
    def flux(self, x, deriv=None):
        r"""Evaluate the photometric flux, normalized to the zero-point
        flux.

        Args:
            x (dict): Atmosphere parameters; keys must match
                `axis_labels` property, values must be double.
            deriv (dict, optional): Flags indicating whether to evaluate 
                derivative with respect to each atmosphere parameter; 
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

        x_vec, deriv_vec = self._vector_args(x, deriv)

        return pyc._interp_photgrid_flux(self._photgrid, x_vec, deriv_vec)
