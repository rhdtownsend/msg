.. _fortran-walkthrough:

*******************
Fortran Walkthrough
*******************

This chapter provides a walkthrough of using the MSG Fortran interface
to evaluate flux and intensity spectra for a model of Sirius
(:math:`\alpha` Canis Majoris). In that respect it mirrors the
:ref:`python-walkthrough`; but rather than using a notebook the focus
is on a short program. It's presumed that you've already downloaded
the :grids:`sg-demo.h5` file and placed it in your working
directory.

Source Code
===========

Create a new file, :file:`demo_msg.f90`, and paste in the following
source code:

.. literalinclude:: demo_msg.f90
   :language: fortran

A few comments on the code:

* The `use forum_m` statement provides access to the :git:`Fortran
  Utility Module (ForUM) <rhdtownsend/forum/>`. For the purposes of
  the demo program, this module defines the `RD` kind type parameter
  for double precision real variables.

* The `use fmsg_m` statement provides access to the MSG high-level
  Fortran interface.

* Because Fortran doesn't have `dict` datatypes, the atmosphere
  parameters must be passed to MSG as a plain array (here, stored in
  the variable `vx`). The ordering of parameters in the array should
  match the case-sensitive alphabetical ordering of the parameter
  labels.

Compiling
=========

The next step is to compile the demo program. Make sure the
:envvar:`MSG_DIR` environment variable is set, as described in the
:ref:`quick-start` chapter. Then, enter the following on the command line:

.. prompt:: bash

   gfortran -o demo_msg demo_msg.f90 -I$MSG_DIR/include `$MSG_DIR/scripts/fmsg_link`

The :code:`-I$MSG_DIR/include` option tells the compiler where to find
the module definition (:file:`.mod`) files, while the
:code:`$MSG_DIR/scripts/fmsg_link` clause (note the enclosing
backticks) runs a link script that returns the compiler flags
necessary to link the program.

Running
=======




