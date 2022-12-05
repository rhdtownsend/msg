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

  
.. toctree::
   :maxdepth: 2

   data-schema/files.rst
   data-schema/groups.rst
