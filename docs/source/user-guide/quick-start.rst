.. _quick-start:

***********
Quick Start
***********

To get started with MSG, follow these five simple steps:

* install the `MESA Software Development Kit <mesa-sdk_>`__;
* download the `MSG source code <tarball_>`__;
* unpack the source code using the :command:`tar` utility;
* set the :envvar:`MSG_DIR` environment variable to point to the
  newly created source directory;
* compile MSG using the command :command:`make -C $MSG_DIR`.
* test MSG using the command :command:`make -C $MSG_DIR test`.

For a more in-depth installation guide that covers alternative
use-cases, refer to the :ref:`installation` chapter. If the code
doesn't compile properly, consult the :ref:`troubleshooting`
chapter. Otherwise, proceed to the next chapter where you'll put
together your first MSG calculation.
