.. _installation:

************
Installation
************

This chapter discusses MSG installation in detail. If you just want
to get up and running, have a look at the :ref:`quick-start` chapter.

Pre-Requisites
==============

To compile and run MSG, you'll need the following software
components:

* A modern (2003+) Fortran compiler
* The :netlib:`LAPACK <lapack>` linear algebra library
* The :netlib:`LAPACK95 <lapack95>` Fortran 95
  interface to LAPACK
* The :git:`fypp <aradi/fypp>` Fortran pre-processor
* The `HDF5 <https://www.hdfgroup.org/solutions/hdf5/>`__ data management library

On Linux and MacOS platforms, these components are bundled together in
the `MESA Software Development Kit (SDK) <mesa-sdk>`__. Using this SDK
is `strongly` recommended.

Building MSG
============

Download the `MSG source code <tarball_>`__, and unpack it
from the command line using the :command:`tar` utility:

.. prompt:: bash
   :substitutions:

   tar xf msg-|version|.tar.gz

Set the :envvar:`MSG_DIR` environment variable with the path to the
newly created source directory; this can be achieved e.g. using the
:command:`realpath` command\ [#realpath]_:

.. prompt:: bash
   :substitutions:

   export MSG_DIR=$(realpath msg-|version|)

Finally, compile MSG using the :command:`make` utility:

.. prompt:: bash

   make -j -C $MSG_DIR
   
(the :command:`-j` flags tells :command:`make` to use multiple cores,
speeding up the build).  If things go awry, consult the
:ref:`troubleshooting` chapter.

Custom Builds
=============

Custom builds of MSG can be created by setting certain environment
variables, and/or variables in the file
:file:`{$MSG_DIR}/src/build/Makefile`, to the value ``yes``. The
following variables are currently supported:

DEBUG
  Enable debugging mode (default ``no``)

OMP
  Enable OpenMP parallelization (default ``yes``)

FPE
  Enable floating point exception checks (default ``yes``)

PYTHON
  Enable building of Python interface (default ``yes``)

TEST
  Enable building of testing tools (default ``yes``)

TOOLS
  Enable building of development tools (default ``no``)

If a variable is not set, then its default value is assumed.

.. _github-access:

GitHub Access
=============

Sometimes, you'll want to try out new features in MSG that haven't
yet made it into a formal release. In such cases, you can check out
MSG directly from the :git:`rhdtownsend/msg` git repository on
:git:`GitHub <>`:

.. prompt:: bash

   git clone --recurse-submodules https://github.com/rhdtownsend/msg.git

However, a word of caution: MSG is under constant development, and
features in the ``main`` branch can change without warning.

.. rubric:: footnote

.. [#realpath] The :command:`realpath` command is included in the GNU
               `CoreUtils <https://www.gnu.org/software/coreutils/>`__
               package. Mac OS users can install CoreUtils using
               `MacPorts <https://www.macports.org/>`__ or `Homebrew
               <https://brew.sh/>`__.
