#cython: language_level=3
#
# Module  : pymsg_common
# Purpose : Cython interface to libcmsg (common parts)
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

# C definitions

cdef extern from "cmsg.h":

    cdef void get_msg_version(char *version);

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

# Routines

def handle_error(stat):

    # Take action based on the stat value

    if stat == STAT_OK:
        return
    elif stat == STAT_OUT_OF_BOUNDS_AXIS_LO:
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

# Set the version number

cdef char version[17]

get_msg_version(version)
__version__ = version.decode('ascii')

    
