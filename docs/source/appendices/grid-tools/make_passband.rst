.. _grid-tools-make_passband:

make_passband
~~~~~~~~~~~~~

The :command:`specint_to_specgrid` tool reads filter response data,
and writes them to a :f-schema:`passband` file. It accepts the
following command-line arguments:

.. program:: make_passband

.. option:: <input_file_name>

   Name of input file (see below).

.. option:: <F_0>

   Normalizing flux :math:`F_{0}` (:math:`\erg\,\cm^{-2}\,\second^{-1}\,\angstrom^{-1}`).

.. option:: <passband_file_name>

   Name of output :f-schema:`passband` file.

The input file is a text file tabulating wavelength :math:`\lambda`
(:math:`\angstrom`) and passband response function
:math:`S'(\lambda)` (see the :ref:`photometric-colors` section).
