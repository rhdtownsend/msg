.. _grid-tools-synspec_to_specint:

synspec_to_specint
~~~~~~~~~~~~~~~~~~

.. program:: synspec_to_specint

Synopsis
--------

.. code-block:: text

   synspec_to_specint <input_file_name> <output_file_name> [options]

Description
-----------

The :command:`synspec_to_specint` tool extracts spectral data from a
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

.. option:: --file-type <type>

   Type of SYNSPEC file. Valid choices are :code:`flux` (usually
   written by SYNSPEC to the file :file:`fort.7`; default) and
   :code:`intensity` (usually written by SYNSPEC to the file
   :file:`fort.18`).

.. option:: --limb-law <law>	 

   Limb-darkening law in output file (see :ref:`here
   <limb-darkening-laws>` for a list of valid choices). Only used for
   :code:`intensity` file types.
   
.. option:: --mu-range <mu_0>:<n_mu>

   Lower limit and number of points for SYNSPEC's angular
   (:math:`\mu`) grid (as specified by the ``ang0`` and ``nmu``
   parameters, respectively, in the :file:`fort.55` SYNSPEC control
   file). Only used for :code:`intensity` file types.

.. option:: --label <name>:<value>

   Name and value of photospheric parameter label. Can be specified
   multiple times, to define multiple parameters.

