.. _how-msg-works:

*************
How MSG Works
*************

This chapter provides a walkthrough of using the MSG Python interface
to evaluate flux and intensity spectra for a model of Sirius
(:math:`\alpha` Canis Majoris). The code fragments are presented as a
sequence of Jupyter notebook cells, but pasting all of the fragments
into a Python script should work also.

Interpolation
=============

To evaluate a stellar spectrum, MSG interpolates in grids of
pre-calculated data. Focusing on specific intensity evaluation, this
involves constructing a (preferably continuous and smooth) function

.. math::

   I(\mu; \lambda; x, y, z, \ldots)

representing the intensity emerging at direction cosine :math:`\mu`
and wavelength :math:`\lambda` from an atmosphere characterized by a
set of :math:`N` parameters :math:`x, y, z, \ldots` (which can
correspond to quantities such as effective temperature :math:`T_{\rm eff}`, gravity :math:`g`,
etc.).

Direction Cosine
----------------

The :math:`mu` dependence of the specific intensity is represented
using limb-darkening laws. The simplest and most well known is the linear law

.. math::
   :label: eq:linear-law

   \frac{I(\mu; \ldots)}{I(1; \ldots)} = 1 - a (\ldots) \left[1 - \mu\right]

where :math:`I(1; \ldots)` represents the normally emergent
(:math:`\mu=1`) intensity and :math:`a(\ldots)` is the linear
limb-darkening coefficient (here the ellipses :math:`\ldots` represent
the other parameters, which have been omitted for brevity). A better
characterization involves introducing additional :math:`\mu`-dependent
terms on the right-hand side; for instance, the four-coefficient law
devised by :ads_citet:`claret:2000` is

.. math::
   :label: eq:claret-law

   \frac{I(\mu; \ldots)}{I(1, \ldots)} = 1 - \sum_{k=1}^{4} a_{k}(\ldots) \left[1 - \mu^{k/2}\right]

where there are now four limb-darkening coefficients :math:`a_{k}(\ldots)`.

The advantage of using limb-darkening laws is the ease with which
other significant quantities can be calculated. For instance, the
emergent flux

.. math::
   :label: eq:flux

   F(\ldots) = \int_{0}^{1} I(\mu; \ldots) \, \mu \, \diff\mu

can be evaluated analytically, and likewise the :ads_citet:`eddington:1926` intensity moments

.. math::

   \mathcal{E}_{i}(\ldots) = \frac{1}{2} \int_{0}^{1} I(\mu; \ldots) \, \mu^{i} \,\diff\mu.

MSG supports the following limb-darkening laws:

`CONST`
  constant law, where :math:`I` has no dependence on
  :math:`\mu` whatsoever. This is discussed further below.

`LINEAR`
  the linear law given in equation :math:numref:`eq:linear-law` above.

`SQRT`
  the square-root law introduced by :ads_citet:`diaz-cordoves:1992`.

`QUAD`
  the quadratic law introduced by :ads_citet:`wade:1985`.

`CLARET`
  the four-coefficient law given in equation :math:numref:`eq:claret-law` above.

The choice of law is made during grid construction; the coefficients
appearing in the limb-darkening laws (e.g., :math:`a` and
:math:`a_{k}`) are determined from least-squares fits to tabulations
of the specific intensity. In cases where these tabluations include
flux but not specific intensity data, the `CONST` law is used; the
angle-independent specific intensity is determined so that it produces
the correct flux when evaluated using equation :math:numref:`eq:flux`.

Wavelength
----------

The :math:`\lambda` dependence of the specific intensity is represeted
as a piecewise-constant function on a wavelength grid :math:`\lambda =
\{\lambda_{1},\lambda_{2},\ldots,\lambda_{M}\}`:

.. math::

   I(\lambda; \ldots) = I_{i}(\ldots) \qquad \lambda_{i} \leq \lambda < \lambda_{i+1}.

(as before, the ellipses represent the omitted parameters). Mapping
the intensity data :math:`I_{k}` onto a new grid :math:`\lambda' =
\{\lambda'_{1},\lambda'_{2},\ldots\,\lambda'_{M'}\}` is performed
conservatively, according to the expression

.. math::

   I'_{j}(\ldots) = \frac{\int_{\lambda'_{j}}^{\lambda'_{j+1}} I(\lambda; \ldots) \diff{\lambda}}{\lambda'_{j+1} - \lambda_{j}}.

Beyond its simpicity, the advantage of this approach (as compared to
higher-order interpolations) is that the equivalent width of line
profiles is preserved.

Atmosphere Parameters
---------------------

The dependence of the specific intensity on atmosphere parameters
(:math:`x, y, z, \ldots`) is represented using cubic tensor product
interpolation. A (relatively) gentle introduction to tensor product
interpolation is introduced is provided in an :ref:`Appendix
<tensor-product-interpolation>`. The short version is that intensity,
flux, etc. are represented as piecewise-cubic functions `in each
atmospheric parameter`, constructed to be continuous and smooth at the
join between each piecewise region.

Grids often contain holes and/or ragged boundaries (the latter
typically arising near the edge of the region of the :math:`T_{\rm
eff}-\log g` plane corresponding to super-Eddington luminosity). When
an interpolation tries to access such missing data, MSG either
switches to a lower-order scheme, or (if there simply aren't
sufficient data to interpolate) returns with an error.

Photometric Colors
==================

Disk Storage
============

MSG grids are stored on disk in `HDF5
<https://www.hdfgroup.org/solutions/hdf5/>`__ files with a bespoke
schema. Because HDF5 is a portable binary format with support for
on-the-fly compression/decompression, it is ideally suited for the
typically large storage requirements of spectral grids.

Memory Management
=================

It's often the case that the data stored in grid files greatly exceed
the available memory (RAM) capacity. MSG handles such situations by
loading data into memory only when they are required. These data are
retained in memory until a user-defined capacity limit reached (see
the :py:attr:`SpecGrid.cache_limit` and
:py:attr:`PhotGrid.cache_limit` attributes in the
:ref:`python-interface`, and corresponding functionality in the
:ref:`Fortran <fortran-interface>` and :ref:`C <c-interface>`
interfaces); then, the least-recently-used data are flushed to make
room for new data.

