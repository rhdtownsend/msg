.. _fortran-interface:

*****************
Fortran Interface
*****************

The Fortran interface is provided through the :f:mod:`fmsg_m` module,
which defines derived types together with supporting parameters and
procedures.


API Specification
=================

.. f:module:: fmsg_m

.. toctree::
   :maxdepth: 2

   fortran-interface/types.rst
   fortran-interface/params.rst
   fortran-interface/procs.rst


Compiling/Linking
=================

The module file :file:`fmsg_m` for the Fortran interface is provided
in the directory :file:`$MSG_DIR/include`, and executables should be
linked against :file:`$MSG_DIR/lib/libfmsg.so` (Linux) or
:file:`$MSG_DIR/lib/libfmsg.dylib` (MacOS). To simplify this process,
a set of `pkgconf <http://pkgconf.org/>`__ package definition files
are provided in the :file:`$MSG_DIR/lib/pkgconfig` subdirectory. These
files can be used to compile/link a program with :command:`gfortran`
as follows:

.. code-block:: console

   $ gfortran -o myprogram myprogram.f90 `pkgconf --with-path=$MSG_DIR/lib/pkgconfig --cflags --libs fmsg`
