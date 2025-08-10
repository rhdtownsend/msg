.. _grid-tools-make_passband:

make_passband
~~~~~~~~~~~~~

.. program:: make_passband

Synopsis
--------

.. code-block:: text

   make_passband RESPONSE_FILE PASSBAND_FILE [options]

Description
-----------

The :program:`make_passband` tool reads response data from an ASCII
text file, creates a passband function, and write it to a
:f-schema:`passband` file.

The ASCII text file should contain one or more lines, each consisting
of a wavelength value (:math:`\angstrom`) followed by a passband
response function value (see the :ref:`photometric-colors` section).

Options
-------

.. option:: -h, --help

   Print a summary of options.

.. option:: -z, --zero_point=F_0

   Zero-point flux
   (:math:`\erg\,\cm^{-2}\,\second^{-1}\,\angstrom^{-1}`) of the
   photometric system.
