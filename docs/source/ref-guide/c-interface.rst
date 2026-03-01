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
a set of `pkgconf <http://pkgconf.org/>`__ package definition files
are provided in the :file:`$MSG_DIR/lib/pkgconfig` subdirectory. These
files can be used to compile/link a program with :command:`gcc`
as follows:

.. code-block:: console

   $ gcc -o myprogram myprogram.c `pkgconf --with-path=$MSG_DIR/lib/pkgconfig --cflags --libs cmsg`
