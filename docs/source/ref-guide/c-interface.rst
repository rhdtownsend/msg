.. _c-interface:

***********
C Interface
***********

The C interface is provided through a set of functions defined in the
:file:`cmsg.h` header file. These functions are implemented using the
`C interoperability capabilities
<https://gcc.gnu.org/onlinedocs/gfortran/Interoperability-with-C.html>`__
in Fortram 2003/2008/2018, and are based around a pair of `void *`
typedefs --- :c:type:`SpecGrid` and :c:type:`PhotGrid` --- that store
pointers to corresponding Fortran :f:type:`specgrid_t` and
:f:type:`photgrid_t` objects.

API Specification
=================

.. toctree::
   :maxdepth: 2

   c-interface/typedefs.rst
   c-interface/funcs.rst
   c-interface/enums.rst

Compiling/Linking
=================

Headers for the C interface are provided in the header file
:file:`$MSG_DIR/include/cmsg.h`, and executables should be linked
against :file:`$MSG_DIR/lib/libcmsg.so` (Linux) or
:file:`$MSG_DIR/lib/libcmsg.dylib` (MacOS). To simplify this process,
a script :file:`$MSG_DIR/scripts/cmsg_link` is provided that writes
the appropriate linker commands to standard output. This script can be
used to compile/link a program with :command:`gcc` as follows:

.. prompt:: bash

   gcc -I $MSG_DIR/include -o myprogram myprogram.c `$MSG_DIR/scripts/cmsg_link`
   
