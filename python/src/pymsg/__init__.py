# Module  : pymsg
# Purpose : Python interface to MSG
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

"""This module provides the Python interface to the Multidimensional
Specgral Grids (MSG) package.
"""

import os
import sys
import numpy as np

# Set path & import pycmsg

sys.path.insert(0, os.path.join(os.environ['MSG_DIR'], 'lib'))
import pycmsg as pyc

# Attribute definitions

__version__ = pyc._get_msg_version()

# Class definitions

class SpecGrid:
    r"""The SpecGrid class represents a grid of spectroscopic intensity data.

    This grid may be used to interpolate the intensity (or related
    quantities) across a wavelength abscissa and for a set of
    photospheric parameter values.

    """

    def __init__(self, file_name):
        """SpecGrid constructor (via loading data from a `specgrid` file).

        Args:
            file_name (string): Name of the file

        Returns:
            pymsg.SpecGrid: Constructed object.

        Raises:
            FileNotFound: If the the file cannot be found.
            TypeError: If the file contains an incorrect datatype.
        """

        self._specgrid = pyc._load_specgrid(file_name)

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
        """list: Photospheric parameter axis labels."""
        return self._axis_labels

    
    @property
    def axis_x_min(self):
        """dict: Photospheric parameter axis minima."""
        return self._axis_x_min

    
    @property
    def axis_x_max(self):
        """dict: Photospheric parameter axis maxima."""
        return self._axis_x_max

    
    @property
    def lam_min(self):
        """double: Minimum wavelength of grid (Å)."""
        return pyc._get_specgrid_lam_min(self._specgrid)

    
    @property
    def lam_max(self):
        """double: Maximum wavelength of grid (Å)."""
        return pyc._get_specgrid_cache_lam_max(self._specgrid)


    @property
    def cache_lam_min(self):
        """double: Minimum wavelength of grid cache (Å)."""
        return pyc._get_specgrid_cache_lam_min(self._specgrid)
    @cache_lam_min.setter
    def cache_lam_min(self, cache_lam_min):
        pyc._set_specgrid_cache_lam_min(self._specgrid, cache_lam_min)


    @property
    def cache_lam_max(self):
        """double: Maximum wavelength of grid cache (Å)."""
        return pyc._get_specgrid_cache_lam_max(self._specgrid)
    @cache_lam_max.setter
    def cache_lam_max(self, cache_lam_max):
        pyc._set_specgrid_cache_lam_max(self._specgrid, cache_lam_max)
        

    @property
    def cache_usage(self):
        """int: Current memory usage of grid cache (MB)."""
        return pyc._get_specgrid_cache_usage(self._specgrid)


    @property
    def cache_limit(self):
        """int: Maximum memory usage of grid cache (MB)."""
        return pyc._get_specgrid_cache_limit(self._specgrid)
    @cache_limit.setter
    def cache_limit(self, cache_limit):
        pyc._set_specgrid_cache_limit(self._specgrid, cache_limit)


    def flush_cache(self):
        """Flush the grid cache"""
        pyc._flush_specgrid_cache(self._specgrid)


    def intensity(self, x, mu, lam, deriv=None):
        r"""Evaluate the spectroscopic intensity.

        Args:
            x (dict): Photospheric parameters; keys must match 
                `axis_labels` property, values must be double.b
            mu (double): Cosine of angle of emergence relative to 
                surface normal.
            lam (numpy.ndarray): Wavelength abscissa (Å).
            deriv (dict, optional): Flags indicating whether to evaluate 
                derivative with respect to each photospheric parameter; 
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
            x (dict): Photospheric parameters; keys must match
                `axis_labels` property, values must be double.
            k (int): Degree of moment.
            lam (numpy.ndarray): Wavelength abscissa (Å).
            deriv (dict, optional): Flags indicating whether to evaluate 
                derivative with respect to each photospheric parameter; 
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
            x (dict): Photospheric parameters; keys must match
                `axis_labels` property, values must be double.
            l (int): Harmonic degree of moment.
            lam (numpy.ndarray): Wavelength abscissa (Å).
            deriv (dict, optional): Flags indicating whether to evaluate 
                derivative with respect to each photospheric parameter; 
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
            x (dict): Photospheric parameters; keys must match
                `axis_labels` property, values must be double.
            lam (numpy.ndarray): Wavelength abscissa (Å)
            deriv (dict, optional): Flags indicating whether to evaluate 
                derivative with respect to each photospheric parameter; 
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

        return pyc._interp_specgrid_flux(self._specgrid, x_vec, lam,
                                         deriv_vec)

    
class PhotGrid:
    r"""The PhotGrid class represents a grid of photometric intensity data.

    This grid may be used to interpolate the intensity (or related
    quantities) for a set of photospheric parameter values.

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
        """list: Photospheric parameter axis labels."""
        return self._axis_labels

    
    @property
    def axis_x_min(self):
        """dict: Photospheric parameter axis minima."""
        return self._axis_x_min

    
    @property
    def axis_x_max(self):
        """dict: Photospheric parameter axis maxima."""
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
            x (dict): Photospheric parameters; keys must match 
                `axis_labels` property, values must be double.
            mu (double): Cosine of angle of emergence relative to 
                surface normal.
            deriv (dict, optional): Flags indicating whether to evaluate 
                derivative with respect to each photospheric parameter; 
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
            x (dict): Photospheric parameters; keys must match
                `axis_labels` property, values must be double.
            k (int): Degree of moment.
            deriv (dict, optional): Flags indicating whether to evaluate 
                derivative with respect to each photospheric parameter; 
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
            x (dict): Photospheric parameters; keys must match
                `axis_labels` property, values must be double.
            l (int): Harmonic degree of moment.
            deriv (dict, optional): Flags indicating whether to evaluate 
                derivative with respect to each photospheric parameter; 
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
            x (dict): Photospheric parameters; keys must match
                `axis_labels` property, values must be double.
            deriv (dict, optional): Flags indicating whether to evaluate 
                derivative with respect to each photospheric parameter; 
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
