.. _grid-tools-rebin_specint:

rebin_specint
~~~~~~~~~~~~~

.. program:: rebin_to_specint

Synopsis
--------

.. code-block:: text

   rebin_specint <input_file_name> <output_file_name> [options]


Description
-----------

The :command:`specint_to_specint` reads data from a
:f-schema:`specint` file, subsets and/or rebins the data, and then
writes it to a :f-schema:`specgrid` file.

Options
-------

.. option:: --lam-range <min>:<max>

   Range of wavelength values to include in subset.

.. option:: --sampling <type>:<value>

   Wavelength sampling to use when rebinning. Valid choices for
   :code:`<type>` are :code:`R` (fixed resolution) and
   :code:`delta_lam` (fixed spacing).

.. option:: --alignment <align>

   Alignment of the wavelength abscissa, relative to the wavelength
   range. Valid choices are :code:`L` (left), :code:`C` (center;
   default) and :code:`R` (right).
