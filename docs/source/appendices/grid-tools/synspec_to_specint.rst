.. _grid-tools-synspec_to_specint:

synspec_to_specint
~~~~~~~~~~~~~~~~~~

.. program:: synspec_to_specint

Synopsis
--------

.. code-block:: text

   synspec_to_specint SYNSPEC_FILE SPECINT_FILE [options]

Description
-----------

The :program:`synspec_to_specint` tool extracts spectral data from a
file produced by the SYNSPEC spectral synthesis package
:ads_citep:`lanz:2003`, and writes it to a :f-schema:`specint`
file.

For the law selected by the :option:`--limb-law` option, the tool
calculates the limb-darkening coefficients at each wavelength via a
least-squares fit to the function

.. math::

   y(\mu) = 1 - \frac{I_{\lambda}(\mu)}{I_{\lambda}(1)}.

Options
-------

.. option:: -h, --help

   Print a summary of options.

.. option:: -t, --file-type=TYPE

   Type of SYNSPEC file. Valid choices are ``flux`` (usually
   written by SYNSPEC to the file :file:`fort.7`; default) and
   ``intensity`` (usually written by SYNSPEC to the file
   :file:`fort.18`).

.. option:: --limb-law=LAW

   Limb-darkening law in output file (see :ref:`here
   <limb-darkening-laws>` for a list of valid choices; default
   ``CONST``). Required for ``intensity`` file types.
   
.. option:: --mu-min=MIN

   Minimum :math:`\mu` value in SYNSPEC's angular grid (as specified
   by the ``ang0`` parameter in the :file:`fort.55`` SYNSPEC
   control file). Required for ``intensity`` file types.

.. option:: --n-mu=N

   Number of :math:`\mu` values in SYNSPEC's angular grid (as specified
   by the ``nmu`` parameter in the :file:`fort.55`` SYNSPEC
   control file). Required for ``intensity`` file types.

.. option:: -l, --label=NAME:VALUE

   Photospheric parameter name and value. Can be specified multiple
   times, to define multiple parameters.



   
