from setuptools import Extension, setup
from Cython.Build import cythonize

import os

extra_link_args=['-Wl,-rpath,{:s}/../build'.format(os.getcwd())]

extensions = [
    Extension(
        'msg',
        ['msg/msg.pyx'],
        library_dirs=['../build'],
        libraries=['cmsg'],
        extra_link_args=extra_link_args
        )
    ]

setup(
    name='msg',
    ext_modules=cythonize(extensions)
)
