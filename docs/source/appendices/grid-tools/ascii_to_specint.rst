.. _grid-tools-ascii_to_specint:

ascii_to_specint
~~~~~~~~~~~~~~~~

The :command:`ascii_to_specint` tool reads a generic flux spectrum
from an ASCII text file, and writes it to a :f-schema:`specint`
file. It accepts the following command-line arguments:

.. program:: ascii_to_specint

.. option:: <ascii_file_name>

   Name of input ASCII text file (see below).

.. option:: <lam_units>

   Units of wavelength data in input file. Possible choices are :code:`'A'` (:math:`\angstrom`).

.. option:: <flux_units>

   Units of flux data in input file. Possible choices are :code:`'erg/cm^2/s/A'` (:math:`\erg\,\cm^{-2}\,\second^{-1}\,\angstrom^{-1}`).

.. option:: <specint_file_name>

   Name of output :f-schema:`specint` file.

.. option:: <label> (optional)

   Label of atmosphere parameter (must be accompanied by a
   corresponding :option:`<value>` argument).

.. option:: <value> (optional)

   Value of atmosphere parameter (must be accompanied by a
   corresponding :option:`<label>` argument).

Note that :option:`<label>` and :option:`<value>` parameters must be
paired; and that there can be multiple of these pairs. The input ASCII
text file should contain one or more lines, each consisting of a
wavelength value followed by a flux value.
