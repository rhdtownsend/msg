.. _troubleshooting:

***************
Troubleshooting
***************

Missing ``forum.inc``
=====================

During compilation, if the error ``include file 'forum.inc' not
found`` arises then it's likely you have an incomplete copy of the
source code. Verify that when you :ref:`checked out <github-access>`
the code from GitHub, you used the ``--recurse-submodules``
option.

Other Problems
==============

.. _open-an-issue:

If you encounter something else that doesn't work as it should, please
:git:`open an issue <rhdtownsend/msg/issues>` on GitHub. In your
issue, please specify the following:

* The release of MSG you are using (e.g. 2.0).
* The operating system and architecture you are using (e.g., MacOS 15.5 on Apple Silicon).
* A brief description of the problem.
* A narrative of the steps to reproduce the problem.
