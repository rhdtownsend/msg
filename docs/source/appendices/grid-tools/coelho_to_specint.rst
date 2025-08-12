.. _grid-tools-coelho_to_specint:

coelho_to_specint
~~~~~~~~~~~~~~~~~

.. program:: coelho_to_specint

Synopsis
--------

.. code-block:: text

   coelho_to_specint COELHO_FILE SPECINT_FILE [options]

Description
-----------

The :program:`coelho_to_specint` tool extracts a flux spectrum from a
data file in FITS format (with a schema described at
`http://specmodels.iag.usp.br/ <http://specmodels.iag.usp.br/>`__ for
the :ads_citealp:`coelho:2014` spectral library), and writes it to a
:f-schema:`specint` file.

Options
-------

.. option:: -h, --help

   Print a summary of options.

.. option:: -t, --file-type=TYPE

   Input file type. This determines the wavelength abscissa adopted
   for the input file. Valid choices are ``linear`` (uniform
   wavelength spacing) and ``log`` (logarithmic wavelength
   spacing).

.. note::

   In order for the :program:`coelho_to_specint` tool to be built, you
   must first uncomment/edit the line in
   :file:`$MSG_DIR/build/Makefile` that sets the :envvar:`FITS_LDFLAGS`
   variable. This variable defines the flags used to link against your
   system's FITS library.
