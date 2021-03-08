#!/usr/bin/env python

import numpy as np

d = np.genfromtxt('kepler_response_hires1.txt', skip_header=9, encoding='UTF-16')

lam = d[:,0]*10
S = d[:,1]

with open('kepler.txt', 'w') as f:

    for i in range(len(lam)):
        f.write(f'{lam[i]} {S[i]}\n')


