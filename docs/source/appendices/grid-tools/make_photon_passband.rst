.. _grid-tools-make_photon_passband:

make_passband
~~~~~~~~~~~~~

.. program:: make_photon_passband

Synopsis
--------

.. code-block:: text

   make_passband PASSBAND_FILE [options]

Description
-----------

The :command:`make_photon_passband` tool creates a passband function
for evaluating photon fluxes, and write it to a :f-schema:`passband`
file.

Options
-------

.. option:: -h, --help

   Print a summary of options.

.. option:: --lambda-min=MIN

   Minimum wavelength (:math:`\angstrom`).

.. option:: --lambda-max=MAX

   Maximum wavelength (:math:`\angstrom`).
