.. _grid-tools-make_passband:

make_passband
~~~~~~~~~~~~~

.. program:: make_passband

Synopsis
--------

.. code-block:: text

   make_passband <input_file_name> <output_file_name> [options]

Description
-----------

The :command:`make_passband` tool reads response data, and writes them
to a :f-schema:`passband` file. The input file is a text file
tabulating wavelength :math:`\lambda` (:math:`\angstrom`) and passband
response function :math:`S'(\lambda)` (see the
:ref:`photometric-colors` section).

Options
-------

.. option:: --zero_point=<F_0>

   Zero-point flux
   (:math:`\erg\,\cm^{-2}\,\second^{-1}\,\angstrom^{-1}`) of the
   photometric system.
