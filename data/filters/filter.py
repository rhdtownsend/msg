#

import h5py as h5

# Write a filter to file

def write_filter(lam, S, filename):

    with h5.File(filename, 'w') as f:

        f.create_dataset('lambda', data=lam)
        f.create_dataset('S', data=S)

        
