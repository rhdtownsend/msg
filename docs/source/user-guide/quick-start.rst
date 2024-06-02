.. _quick-start:

***********
Quick Start
***********

To get started with MSG, follow these simple steps:

* Install the `MESA Software Development Kit <mesa-sdk_>`__.
* Download the `MSG source code <tarball_url_>`__.
* Unpack the source code using the :command:`tar` utility.
* Set the :envvar:`MSG_DIR` environment variable to point to the
  newly created source directory.
* Compile MSG using the command :command:`make -C $MSG_DIR`.
* Test MSG using the command :command:`make -C $MSG_DIR test`.
* Install the :py:mod:`pymsg` Python module using the command :command:`pip install $MSG_DIR/python`.

(the last step can be skipped if you don't plan to use the Python
interface).

For a more in-depth installation guide that covers alternative
use-cases, refer to the :ref:`installation` chapter. If the code
doesn't compile properly, consult the :ref:`troubleshooting`
chapter. Otherwise, proceed to the next chapter where you'll undertake
your first MSG calculations.
