.. _grid-tools-ferre_to_specint:

ferre_to_specint
~~~~~~~~~~~~~~~~

The :command:`ferre_to_specint` tool extracts a series of flux spectra
from a data file in FERRE format (see the `FERRE User Guide
<http://www.as.utexas.edu/~hebe/ferre/ferre.pdf>`__), and writes them
to :f-schema:`specint` files. It accepts the following
command-line arguments:

.. program:: ferre_to_specint

.. option:: <ferre_file_name>

   Name of input FERRE file.

.. option:: <ferre_file_type>

   Type of input file. This determines the mapping between photospheric
   parameters given in the input file, and photospheric parameters
   written to the output file. Supported options are: 'CAP18' (for the
   :ads_citealp:`allende:2018` grids).

.. option:: <specint_prefix>

   Prefix of output :f-schema:`specint` files; these will have the name
   :file:`<specint_prefix>-NNNNNNNN.h5`, wehre :file:`NNNNNNNN` is the
   zero-padded index of the spectrum (starting at 1).
