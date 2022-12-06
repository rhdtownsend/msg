.. _data-schema-conventions:

Conventions
===========

All MSG data files adhere to the following conventions:

* HDF5 groups are used to store nested data structures that correspond
  resonably closely to the derived data types (e.g.,
  :f:type:`specgrid_t`) of the Fortran interface.
* Real values are written with HDF5 type `H5T_IEEE_F64LE`, or
  `H5T_IEEE_F32LE` when reduced precision is permitted.
* Integer values are written with HDF5 type `H5T_STD_I32LE`.
* Logical (boolean) values are written with HDF5 type `H5T_STD_I32LE`, with
  1 corresponding to true, and 0 corresponding to false.
* Character valuesa are written with HDF5 type `H5T_NATIVE_CHARACTER`.

  
