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

"""This module provides an interface to MSG (Multidimensinal Stellar
Grids), a library for synthesizing astrophysical spectra and
photometric colors via interpolation in pre-calculated grids.
"""

from .specgrid import SpecGrid
from .photgrid import PhotGrid

from .pycmsg import _get_msg_version

__version__ = _get_msg_version()
