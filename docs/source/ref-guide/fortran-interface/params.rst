.. _fortran-params:

 .. f:currentmodule:: fmsg_m

Parameters
----------

.. f:variable:: int RD
   :attrs: parameter

   Kind type parameter for reals.


.. f:variable:: int LABEL_LEN
   :attrs: parameter

   Length of :f:type:`axis_t` labels.


.. f:variable:: int ~fmsg_m/STAT_OK
   :attrs: parameter

   Status code indicating procedure call completed without error.


.. f:variable:: int STAT_OUT_OF_BOUNDS_RANGE_LO
   :attrs: parameter
   
   Status code indicating procedure call encountered an out-of-bounds reference, below the range minimum.


.. f:variable:: int STAT_OUT_OF_BOUNDS_RANGE_HI
   :attrs: parameter
   
   Status code indicating procedure call encountered an out-of-bounds reference, above the range maximum.
   

.. f:variable:: int STAT_OUT_OF_BOUNDS_AXIS_LO
   :attrs: parameter
   
   Status code indicating procedure call encountered an out-of-bounds reference, below the axis minimum.


.. f:variable:: int STAT_OUT_OF_BOUNDS_AXIS_HI
   :attrs: parameter
   
   Status code indicating procedure call encountered an out-of-bounds reference, above the axis maximum.
   

.. f:variable:: int STAT_OUT_OF_BOUNDS_LAM_LO
   :attrs: parameter
   
   Status code indicating procedure call encountered an out-of-bounds reference, below the wavelength minimum.


.. f:variable:: int STAT_OUT_OF_BOUNDS_LAM_HI
   :attrs: parameter
   
   Status code indicating procedure call encountered an out-of-bounds reference, above the wavelength maximum.
   

.. f:variable:: int STAT_OUT_OF_BOUNDS_MU_LO
   :attrs: parameter
   
   Status code indicating procedure call encountered an out-of-bounds reference, below the emergence cosine minimum.


.. f:variable:: int STAT_OUT_OF_BOUNDS_MU_HI
   :attrs: parameter
   
   Status code indicating procedure call encountered an out-of-bounds reference, above the emergence cosine maximum.
   

.. f:variable:: int STAT_UNAVAILABLE_DATA
   :attrs: parameter
   
   Status code indicating procedure call encountered unavailable data.
   

.. f:variable:: int STAT_INVALID_ARGUMENT
   :attrs: parameter
   
   Status code indicating procedure call encountered an invalid argument.


.. f:variable:: int STAT_FILE_NOT_FOUND
   :attrs: parameter
   
   Status code indicating procedure call encountered a file that could not be found.


.. f:variable:: int STAT_INVALID_FILE_TYPE
   :attrs: parameter
   
   Status code indicating procedure call encountered a file with an invalid type.


.. f:variable:: int STAT_INVALID_GROUP_TYPE
   :attrs: parameter
   
   Status code indicating procedure call encountered a file group with an invalid type.


.. f:variable:: int STAT_INVALID_GROUP_REVISION
   :attrs: parameter
   
   Status code indicating procedure call encountered a file group with an invalid revision number.

   
.. f:variable:: int STAT_INVALID_OMP_CONFIG
   :attrs: parameter

   Status code indicating procedure call encountered an invalid OpenMP configuration. This
   can be resolved by setting the :envvar:`OMP_CANCELLATION` environment variable to `TRUE`.
	   
