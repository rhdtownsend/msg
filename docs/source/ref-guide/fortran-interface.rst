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
a script :file:`$MSG_DIR/scripts/fmsg_link` is provided that writes
the appropriate linker commands to standard output. This script can be
used to compile/link a program with :command:`gfortran` as follows:

.. prompt:: bash

   gfortran -o myprogram myprogram.f90 -I $MSG_DIR/include `$MSG_DIR/scripts/fmsg_link`
