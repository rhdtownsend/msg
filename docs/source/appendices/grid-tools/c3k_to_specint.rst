.. _grid-tools-c3k_to_specint:

c3k_to_specint
~~~~~~~~~~~~~~

.. program:: c3k_to_specint

Synopsis
--------

.. code-block:: text

   c3k_to_specint C3K_FILE SPECINT_PREFIX [options]

Description
-----------

The :program:`c3k_to_specint` tool extracts a series of flux spectra
from a data file in C3K format, and writes them to :f-schema:`specint`
files. Output files have the name :file:`SPECINT_PREFIX-NNNNNNNN.h5`,
where :file:`NNNNNNNN` is the zero-padded index of the spectrum
(starting at 1).

Options
-------

.. option:: -h, --help

   Print a summary of options.
