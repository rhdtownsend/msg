from setuptools import Extension, setup
from Cython.Build import cythonize

import os
import platform

msg_dir = os.environ.get('MSG_DIR')

if msg_dir is None:
    raise Exception('MSG_DIR environment variable is not set')

extra_link_args = []

if platform.system == 'Linux':
    extra_link_args += ['-Wl,-rpath,{:s}/lib'.format(msg_dir)]

extensions = [
    Extension(
        'msg',
        ['msg.pyx'],
        include_dirs=['{:s}/include'.format(msg_dir)],
        library_dirs=['{:s}/lib'.format(msg_dir)],
        libraries=['cmsg'],
        extra_link_args=extra_link_args
        )
    ]

setup(
    name='msg',
    ext_modules=cythonize(extensions)
)
