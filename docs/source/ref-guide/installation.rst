.. _installation:

************
Installation
************

This chapter discusses MSG installation in detail. If you just want
to get up and running, have a look at the :ref:`quick-start` chapter.

Pre-Requisites
==============

To compile and use MSG, you'll need the following software
components:

* A modern (2008+) Fortran compiler
* The :netlib:`LAPACK <lapack>` linear algebra library
* The :netlib:`LAPACK95 <lapack95>` Fortran 95
  interface to LAPACK
* The :git:`fypp <aradi/fypp>` Fortran pre-processor
* The `HDF5 <https://www.hdfgroup.org/solutions/hdf5/>`__ data management library

On Linux and MacOS platforms, these components are bundled together in
the `MESA Software Development Kit (SDK) <mesa-sdk_>`__. Using this SDK
is `strongly` recommended.

If you're planning on using the :py:mod:`pymsg` Python module, then
you'll also need the following components:

* `Python 3.7 <https://www.python.org/downloads/>`__ (or more recent)
* `NumPy 1.15 <https://numpy.org/>`__ (or more recent)

Building MSG
============

Download the `MSG source code <tarball_url_>`__, and unpack it
from the command line using the :command:`tar` utility:

.. code-block:: console
   :substitutions:

   $ tar xf |tarball|

Set the :envvar:`MSG_DIR` environment variable with the path to the
newly created source directory; this can be achieved, e.g., using the
:command:`realpath` command\ [#realpath]_:

.. code-block:: console
   :substitutions:

   $ export MSG_DIR=$(realpath |dist_dir|)

Finally, compile MSG using the :command:`make` utility:

.. code-block:: console

   $ make -j -C $MSG_DIR
   
(the ``-j`` flags tells :command:`make` to use multiple cores,
speeding up the build).  If things go awry, consult the
:ref:`troubleshooting` chapter.

Testing MSG
===========

To test MSG, use the command

.. code-block:: console

   $ make -C $MSG_DIR test

This runs unit tests for the various Fortran modules that together
compose the MSG library. At the end of the test sequence, a summary of
the number of tests passed and failed is printed. All tests should
pass; if one or more fails, then please :git:`open an issue
<rhdtownsend/msg/issues>` to report the problem.

Installing the :py:mod:`pymsg` Module
=====================================

To install the :py:mod:`pymsg` Python module, use the :command:`pip` tool:

.. code-block:: console

   $ pip install $MSG_DIR/python

You can alternatively add the :file:`$MSG_DIR/python/src` directory to
the :envvar:`PYTHONPATH` environment variable. Note that in order for
:py:mod:`pymsg` to function correctly, the :envvar:`MSG_DIR`
environment variable must be set at Python runtime (this variable
allows the module to find the Python extension that interfaces to the
back-end).

Custom Builds
=============

Custom builds of MSG can be created by setting certain environment
variables to the value ``yes``. The following variables are currently
supported:

:envvar:`DEBUG`
  Enable debugging mode (default ``no``)

:envvar:`FPE`
  Enable floating point exception checks (default ``yes``)

:envvar:`OMP`
  Enable OpenMP parallelization (default ``yes``)

:envvar:`PYTHON`
  Enable building of the Python extension (default ``yes``)

:envvar:`TEST`
  Enable building of testing tools (default ``yes``)

:envvar:`TOOLS`
  Enable building of development tools (default ``yes``)

If an environment variable is not set, then its default value is assumed.

.. _github-access:

GitHub Access
=============

Sometimes, you'll want to try out new features in MSG that haven't
yet made it into a formal release. In such cases, you can check out
MSG directly from the :git:`rhdtownsend/msg` git repository on
:git:`GitHub <>`:

.. code-block:: console

   $ git clone --recurse-submodules https://github.com/rhdtownsend/msg.git

However, a word of caution: MSG is under constant development, and
features in the ``main`` branch can change without warning.

.. rubric:: footnote

.. [#realpath] The :command:`realpath` command is included in the GNU
               `CoreUtils <https://www.gnu.org/software/coreutils/>`__
               package. Mac OS users can install CoreUtils using
               `MacPorts <https://www.macports.org/>`__ or `Homebrew
               <https://brew.sh/>`__.
