.. _data-schema:

***********
Data Schema
***********

This chapter specifies the data schema used by MSG data files. These
files are stored on disk in `HDF5
<https://www.hdfgroup.org/solutions/hdf5/>`__ format, and the schema
describes what data appear in each type of file.

All files adhere to the following conventions:

* Groups are used to store nested data structures that correspond
  resonably closely to the derived data types (e.g.,
  :f:type:`specgrid_t`) of the Fortran interface.
* Real values are written with type `H5T_IEEE_F64LE`, or
  `H5T_IEEE_F32LE` when reduced precision is permitted.
* Integer values are written with type `H5T_STD_I32LE`.
* Logical (boolean) values are written with type `H5T_STD_I32LE`, with
  1 corresponding to true, and 0 corresponding to false.
* Character valuesa are written with type `H5T_NATIVE_CHARACTER`.

  
Files
=====

.. toctree::
   :maxdepth: 2

   data-schema/specint-file.rst
   data-schema/specgrid-file.rst
   data-schema/passband-file.rst
   data-schema/photgrid-file.rst
   data-schema/photint-file.rst

   
Groups
======

.. toctree::
   :maxdepth: 2

   data-schema/axis-group.rst
   data-schema/cubint-group.rst
   data-schema/limb-group.rst
   data-schema/range-group.rst
   data-schema/passband-group.rst
   data-schema/photgrid-group.rst
   data-schema/photint-group.rst
   data-schema/specgrid-group.rst
   data-schema/specint-group.rst
   data-schema/vgrid-group.rst
