.. _exception-handling:

 .. f:currentmodule:: fmsg_m

******************
Exception Handling
******************

This chapter discusses how MSG handles exceptions. These can arise in a variety of circumstances:

* Attempts to load grids from files that are missing or corrupt.
* Attempts to interpolate at locations outside the bounds of a grid.
* Attempts to interpolate at locations where grid data are missing (so-called :ref:`grid voids <grid-voids>`).
* Attempts to interpolate with incomplete specification of photospheric parameters.
* Attempts to interpolate for invalid wavelength and/or angle parameters.

When an exception occurs, how it's signaled depends on the language interface being used.

Python
======
  
Using the Python interface, exceptions are signaled using the
language's built-in exception handling capabilities. The list of
exceptions that can be thrown by each class method is provided in the
:ref:`python-interface` chapter.

Fortran
=======

Using the Fortran interface, exceptions are signaled through the
optional procedure argument ``stat``. If this argument is present,
then on return it is set to one of the status code values defined in
the :ref:`Fortran parameters <fortran-params>` section. The value
:f:var:`STAT_OK` indicates that no problem was encountered; other
values signal an exception. If ``stat`` is not present when an
exception occurs, then execution halts with a message printed to
standard error.

C
=

Using the C interface, exceptions are signaled through the pointer
function argument ``stat``. If this pointer is non-null, then on
return the pointer target ``*stat`` is set to one of the status code
values defined in the :ref:`C enums <c-enums>` section. The value
:c:enumerator:`STAT_OK` indicates that no problem was encountered;
other values signal an exception. If ``stat`` is null when an
exception occurs, then execution halts with a message printed to
standard error.
