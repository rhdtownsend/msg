.. _python-interface:

****************
Python Interface
****************

The Python interface is provided through the :py:mod:`pymsg` module,
which defines the :py:class:`SpecGrid` and :py:class:`PhotGrid`
classes. It is implemented in `Cython <https://cython.org/>`__ using
calls to the :ref:`c-interface`.

API Specification
=================

.. toctree::
   :maxdepth: 2

   python-interface/specgrid.rst
   python-interface/photgrid.rst

Importing
=========

The :py:mod:`pymsg` module is provided in the :file:`$MSG_DIR/python`
directory. To import the module, this directory should be added to the
Python path --- for instance by setting the :envvar:`PYTHONPATH`
environment variable, as discussed `here <https://docs.python.org/3/using/cmdline.html#envvar-PYTHONPATH>`__.

