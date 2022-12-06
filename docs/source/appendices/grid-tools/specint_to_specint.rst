.. _grid-tools-specint_to_specint:

specint_to_specint
~~~~~~~~~~~~~~~~~~

The :command:`specint_to_specint` tool subsets and/or rebins data in
an existing :f-schema:`specint` file It accepts the
following command-line arguments:

.. program:: specint_to_specint

.. option:: <specint_file_name_in>

   Name of input :f-schema:`specint` file.

.. option:: <specint_file_name_out>

   Name of output :f-schema:`specint` file.

.. option:: lam_min=<value> (optional)

   Subset to have a minimum wavelength of at least `<value>` (:math:`\angstrom`).

.. option:: lam_max=<value> (optional)

   Subset to have a maximum wavelength of at most `<value>` (:math:`\angstrom`).

.. option:: R=<value> (optional)

   Rebin to have a uniform resolution :math:`\mathcal{R}` of `<value>`.

.. option:: dlam=<value> (optional)

   Rebin to have a uniform wavelength spacing :math:`\Delta \lambda` of `<value>` (:math:`\angstrom`).

.. option:: just=<L|R> (optional)

   Justify the new wavelength abscissa to the left ('L') or right ('R').
