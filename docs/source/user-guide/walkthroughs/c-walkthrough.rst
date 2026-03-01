.. _walkthroughs-c:

C Walkthrough
=============

This section reprises the steps of the :ref:`walkthroughs-python` --- evaluating
an irradiance spectrum and photometric colors for Sirius A --- but now using the MSG
C interface.

Preparation
-----------

In your working directory, create a new file
:file:`c-walkthrough.c` with the following source code:

.. literalinclude:: c-walkthrough.c
   :language: C

A few brief comments on the code:

* The ``#include "cmsg.h"`` statement includes the header definitions
  for the MSG C interface.

* Because C doesn't have :py:class:`dict` datatypes, the photospheric
  parameters must be passed to MSG as a plain array (here, stored in
  the variable ``x_vec``). A loop with :c:func:`strcmp()` calls is used to make
  sure the correct values are stored in each array element.

* Many of the calls to MSG routines (e.g., :c:func:`load_specgrid`,
  :c:func:`interp_specgrid_flux`) contain ``NULL`` trailing
  arguments; these correspond to omitted optional arguments.

Compiling
---------

The next step is to compile the demo program. Make sure the
:envvar:`MSG_DIR` environment variable is set, as described in the
:ref:`quick-start` chapter. Then, run :command:`gcc` to compile the
program:

.. code-block:: console

   $ gcc -o c-walkthrough c-walkthrough.c `pkgconf --with-path=$MSG_DIR/lib/pkgconfig --cflags --libs cmsg`

The ```pkgconf ...``` clause (note the enclosing backticks) uses
`pkgconf <http://pkgconf.org/>`__ to generate the compiler flags
necessary to link the program against the appropriate libraries.

Running
-------

To run the code, first create symbolic link to the demo grid and passbands:

.. code-block:: console

   $ ln -s $MSG_DIR/data/grids/sg-demo.h5
   $ ln -s $MSG_DIR/data/passbands/pb-Generic-Johnson.U-Vega.h5
   $ ln -s $MSG_DIR/data/passbands/pb-Generic-Johnson.B-Vega.h5
   $ ln -s $MSG_DIR/data/passbands/pb-Generic-Johnson.V-Vega.h5

Then, execute the command

.. code-block:: console

   $ ./c-walkthrough

The code will create a file :file:`spectrum.dat` containing the
irradiance spectrum for Sirius A (as an ASCII table), and print out
the apparent V-band magnitude and colors of the star.
