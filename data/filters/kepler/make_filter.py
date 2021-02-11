#!/usr/bin/env python

import numpy as np
import filter as fl

d = np.genfromtxt('kepler_response_hires1.txt', skip_header=9, encoding='UTF-16')

lam = d[:,0]*10
S = d[:,1]

fl.write_filter(lam, S, 'kepler_filter.h5')



