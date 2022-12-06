.. _c-interface:

***********
C Interface
***********

The C interface is provided through the :file:`cmsg.h` header file,
which defines typedefs, enums and functions.


API Specification
=================

.. toctree::
   :maxdepth: 2

   c-interface/typedefs.rst
   c-interface/enums.rst
   c-interface/funcs.rst

   
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
   
