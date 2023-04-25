.. _grid-tools-c3k_to_specint:

c3k_to_specint
~~~~~~~~~~~~~~

The :command:`c3k_to_specint` tool extracts a series of flux spectra
from a data file in C3K format, and writes them to :f-schema:`specint`
files. It accepts the following command-line arguments:

.. program:: c3k_to_specint

.. option:: <c3k_file_name>

   Name of input C3K file.

.. option:: <specint_prefix>

   Prefix of output :f-schema:`specint` files; these will have the name
   :file:`<specint_prefix>-NNNNNNNN.h5`, where :file:`NNNNNNNN` is the
   zero-padded index of the spectrum (starting at 1).
