.. _grid-tools-rebin_specint:

rebin_specint
~~~~~~~~~~~~~

.. program:: rebin_to_specint

Synopsis
--------

.. code-block:: text

   rebin_specint INPUT_FILE OUTPUT_FILE [options]


Description
-----------

The :program:`specint_to_specint` tool reads data from a
:f-schema:`specint` file, subsets and/or rebins the data, and then
writes it to a :f-schema:`specgrid` file.

Options
-------

.. option:: -h, --help

   Print a summary of options.

.. option:: --lambda-min=MIN

   Minimum wavelength (:math:`\angstrom`).

.. option:: --lambda-max=MAX

   Maximum wavelength (:math:`\angstrom`).

.. option:: -t, --sampling-type=TYPE

   Sampling type when rebinning. Valid choices are :code:`R` (fixed
   wavelength resolution) and :code:`delta_lam` (fixed wavelength
   spacing).

.. option:: -t, --sampling-value=VALUE

   Sampling value when rebinning.

.. option:: -a, --sampling-alignment=ALIGN

   Sampling alignment when rebinning. Valid choices are :code:`center`
   (default), :code:`left` and :code:`right`.
