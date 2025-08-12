.. _grid-tools-ferre_to_specint:

ferre_to_specint
~~~~~~~~~~~~~~~~

.. program:: ferre_to_specint

Synopsis
--------

.. code-block:: text

   ferre_to_specint FERRE_FILE SPECINT_PREFIX [options]

Description
-----------

The :program:`ferre_to_specint` tool extracts a series of flux spectra
from a data file in `FERRE <http://www.as.utexas.edu/~hebe/ferre>`__
format, and writes them to :f-schema:`specint` files. Output files
have the name :file:`SPECINT_PREFIX-NNNNNNNN.h5`, where
:file:`NNNNNNNN` is the zero-padded index of the spectrum (starting at
1).

Options
-------

.. option:: -h, --help

   Print a summary of options.

.. option:: -t, --file-type=TYPE

   Input file type. This determines the mapping between photospheric
   parameters given in the input file, and photospheric parameters
   written to the output file. Valid choices are ``CAP18`` (for
   the :ads_citealp:`allende:2018` grids; default).
