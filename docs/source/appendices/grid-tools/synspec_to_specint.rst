.. _grid-tools-synspec_to_specint:

synspec_to_specint
~~~~~~~~~~~~~~~~~~

The :command:`synspec_to_specint` tool extracts an single intensity
spectrum from a :file:`fort.18` data file produced by the SYNSPEC
spectral synthesis package :ads_citep:`lanz:2003`, and writes it to a
:f-schema:`specint` file. It accepts the following
command-line arguments:

.. program:: synspec_to_specint

.. option:: <synspec_file_name>

   Name of input SYNSPEC file.	      

.. option:: <n_mu>

   Number of :math:`\mu` values in input file (as specified by the
   ``nmu`` parameter in the :file:`fort.55` SYNSPEC control file).

.. option:: <mu_0>

   Minimum :math:`\mu` value in input file (as specified by the
   ``ang0`` parameter in the :file:`fort.55` SYNSPEC control file).

.. option:: <lam_min>

   Minimum wavelength of output file (:math:`\angstrom`).

.. option:: <lam_max>

   Maximum wavelength in output file (:math:`\angstrom`).

.. option:: <R>

   Resolution :math:`\mathcal{R}=\lambda/\Delta\lambda` in output file.

.. option:: <law_str>
     
   Limb-darkening law in output file (see :ref:`here
   <limb-darkening-laws>` for a list of options).

.. option:: <specint_file_name>

   Name of output :f-schema:`specint` file.

.. option:: <label> (optional)

   Label of atmosphere parameter (must be accompanied by a
   corresponding :option:`<value>` argument).

.. option:: <value> (optional)

   Value of atmosphere parameter (must be accompanied by a
   corresponding :option:`<label>` argument).

Note that :option:`<label>` and :option:`<value>` parameters must be
paired; and that there can be multiple of these pairs. For the law
selected by the :option:`<law_str>` option, the tool calculates the
limb-darkening coefficients at each wavelength via a least-squares fit
to the function

.. math::

   y(\mu) = 1 - \frac{I_{\lambda}(\mu;\ldots)}{I_{\lambda}(1;\ldots)}.
