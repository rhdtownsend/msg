.. _walkthroughs-fortran:

Fortran Walkthrough
===================

This section reprises the steps of the :ref:`walkthroughs-python` ---
evaluating an irradiance spectrum and photometric colors for Sirius A --- but now
using the MSG Fortran interface.

Preparation
-----------

In your working directory, create a new file
:file:`fortran-walkthrough.f90` with the following source code:

.. literalinclude:: fortran-walkthrough.f90
   :language: fortran

A few brief comments on the code:

* The ``use forum_m`` statement provides access to the :git:`Fortran
  Utility Module (ForUM) <rhdtownsend/forum/>`. For the purposes of
  the demo program, this module defines the ``RD`` kind type parameter
  for double precision real variables.

* The ``use fmsg_m`` statement provides access to the MSG Fortran
  interface. Primarily, this interface serves to define the
  :f:type:`~fmsg_m/specgrid_t` and :f:type:`~fmsg_m/photgrid_t` datatypes.

* Because Fortran doesn't have :py:class:`dict` datatypes, the photospheric
  parameters must be passed to MSG as a plain array (here, stored in
  the variable ``x_vec``). A ``select case`` construct is used to make
  sure the correct values are stored in each array element.

Compiling
---------

The next step is to compile the demo program. Make sure the
:envvar:`MSG_DIR` environment variable is set, as described in the
:ref:`quick-start` chapter. Then, run :command:`gfortran` to compile the
program:

.. code-block:: console

   $ gfortran -o fortran-walkthrough fortran-walkthrough.f90 `pkgconf --with-path=$MSG_DIR/lib/pkgconfig --cflags --libs fmsg`

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

   $ ./fortran-walkthrough

The code will create a file :file:`spectrum.dat` containing the
irradiance spectrum for Sirius A (as an ASCII table), and print out
the apparent V-band magnitude and colors of the star.
