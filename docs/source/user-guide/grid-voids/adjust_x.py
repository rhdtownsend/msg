# Import standard modules

import os
import numpy as np
import astropy.constants as con
import astropy.units as unt
import matplotlib.pyplot as plt

# Import pymsg

import pymsg

# Load the SpecGrid

MSG_DIR = os.environ['MSG_DIR']
GRID_DIR = os.path.join(MSG_DIR, 'data', 'grids')

specgrid_file_name = os.path.join(GRID_DIR, 'sg-demo.h5')

specgrid = pymsg.SpecGrid(specgrid_file_name)

# Set up atmosphere parametets

x = {'Teff': 15000., 'log(g)': 2.3}

# Attemt an interpolation

lam = np.array([3000., 4000., 5000.])

try:
    
    flux = specgrid.flux(x, lam)
    
except LookupError:

    # Adjust parameters
    
    dx = {'Teff': 0., 'log(g)': 1.0}
    
    x = specgrid.adjust_x(x, dx)
    
    # Attempt again
    
    flux = specgrid.flux(x,lam)
    
