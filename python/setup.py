from setuptools import Extension, setup
from Cython.Build import cythonize

extensions = [
    Extension(
        'msg',
        ['msg/msg.pyx'],
        library_dirs=['/Users/townsend/devel/msg/build'],
        libraries=['cmsg'],
        extra_link_args=['-mmacosx-version-min=10.16']
        )
    ]

setup(
    name='msg',
    ext_modules=cythonize(extensions)
)
