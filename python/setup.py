from setuptools import Extension, setup
from Cython.Build import cythonize

extensions = [
    Extension(
        'msg',
        ['msg/msg.pyx'],
        library_dirs=['../build'],
        libraries=['cmsg']
        )
    ]

setup(
    name='msg',
    ext_modules=cythonize(extensions)
)
