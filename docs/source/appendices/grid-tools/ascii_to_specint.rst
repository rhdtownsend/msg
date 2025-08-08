.. _grid-tools-ascii_to_specint:

ascii_to_specint
~~~~~~~~~~~~~~~~

.. program:: ascii_to_specint

Synopsis
--------

.. code-block:: text

   ascii_to_specint ASCII_FILE SPECINT_FILE [options]

Description
-----------

The :command:`ascii_to_specint` tool reads a generic flux spectrum
from an ASCII text file, and writes it to a :f-schema:`specint`
file.

The ASCII text file should contain one or more lines, each consisting
of a wavelength value followed by a flux value. Blank lines and lines
beginning with :code:`#` are ignored.

Options
-------

.. option:: -h, --help

   Print a summary of options.

.. option:: --lambda-units=UNITS

   Wavelength units of input file. Valid choices are :code:`A`
   (:math:`\angstrom`; default) and :code:`micron` (:math:`\mu`).

.. option:: --flux-units=UNITS

   Flux units of input file. Valid choices are :code:`erg/cm^2/s/A`
   (:math:`\erg\,\cm^{-2}\,\second^{-1}\,\angstrom^{-1}`; default).

.. option:: -l, --label=NAME:VALUE

   Photospheric parameter name/value. Can be specified multiple times,
   to define multiple parameters.
