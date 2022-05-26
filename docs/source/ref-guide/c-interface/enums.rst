.. _c-enums:

Enums
-----

.. c:enum:: Stat

   .. c:enumerator:: STAT_OK

      Status code indicating call completed without error.


   .. c:enumerator:: STAT_OUT_OF_BOUNDS_RANGE_LO
      
      Status code indicating call encountered an out-of-bounds reference, below the range minimum.


   .. c:enumerator:: STAT_OUT_OF_BOUNDS_RANGE_HI
      
      Status code indicating call encountered an out-of-bounds reference, above the range maximum.
      

   .. c:enumerator:: STAT_OUT_OF_BOUNDS_AXIS_LO

      Status code indicating call encountered an out-of-bounds reference, below the axis minimum.


   .. c:enumerator:: STAT_OUT_OF_BOUNDS_AXIS_HI
      
      Status code indicating call encountered an out-of-bounds reference, above the axis maximum.
      

   .. c:enumerator:: STAT_OUT_OF_BOUNDS_LAM_LO
      
      Status code indicating call encountered an out-of-bounds reference, below the wavelength minimum.


   .. c:enumerator:: STAT_OUT_OF_BOUNDS_LAM_HI
      
      Status code indicating call encountered an out-of-bounds reference, above the wavelength maximum.
      

   .. c:enumerator:: STAT_OUT_OF_BOUNDS_MU_LO
      
      Status code indicating call encountered an out-of-bounds reference, below the emergence cosine minimum.


   .. c:enumerator:: STAT_OUT_OF_BOUNDS_MU_HI
      
      Status code indicating call encountered an out-of-bounds reference, above the emergence cosine maximum.
      

   .. c:enumerator:: STAT_UNAVAILABLE_DATA
      
      Status code indicating call encountered unavailable data.
      

   .. c:enumerator:: STAT_INVALID_ARGUMENT
      
      Status code indicating call encountered an invalid argument.


   .. c:enumerator:: STAT_FILE_NOT_FOUND
      
      Status code indicating call encountered a file that could not be found.


   .. c:enumerator:: STAT_INVALID_FILE_TYPE
      
      Status code indicating call encountered a file with an invalid type.


   .. c:enumerator:: STAT_INVALID_FILE_REVISION
      
      Status code indicating call encountered a file with an invalid revision number.
