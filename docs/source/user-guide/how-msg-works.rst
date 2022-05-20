.. _how-msg-works:

*************
How MSG Works
*************

This chapter expands on the :ref:`Python <python-walkthrough>`,
:ref:`Fortran <fortran-walkthrough>` and :ref:`C <c-walkthrough>`
walkthrough chapters, by describing in detail how MSG evaluates
stellar spectra and photometric colors.

Evaluating a Spectrum
=====================

To evaluate a stellar spectrum, MSG interpolates in grids of
pre-calculated spectroscopic data. Focusing on specific intensity
evaluation, this involves constructing a (preferably continuous and
smooth) function

.. math::

   I(\mu; \lambda; x, y, z, \ldots)

representing the intensity emerging at direction cosine :math:`\mu`
and wavelength :math:`\lambda` from an atmosphere characterized by a
set of :math:`N` parameters :math:`x, y, z, \ldots` (which can
correspond to quantities such as effective temperature :math:`T_{\rm eff}`, gravity :math:`g`,
etc.).

.. _limb-darkening-laws:

Limb-Darkening Laws
-------------------

The :math:`\mu` dependence of the specific intensity is represented
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

   \frac{I(\mu; \ldots)}{I(1, \ldots)} = 1 - \sum_{k=1}^{4} a_{k}(\ldots) \left[1 - \mu^{k/2}\right],

where there are now four limb-darkening coefficients :math:`a_{k}(\ldots)`.

The advantage of using limb-darkening laws is the ease with which
other useful quantities can be calculated. For instance, the emergent
flux

.. math::
   :label: eq:flux

   F(\ldots) = \int_{0}^{1} I(\mu; \ldots) \, \mu \, \diff\mu

can be evaluated analytically, as can any of the
:ads_citet:`eddington:1926` intensity moments

.. math::

   \mathcal{E}_{i}(\ldots) = \frac{1}{2} \int_{0}^{1} I(\mu; \ldots) \, \mu^{i} \,\diff\mu.

MSG supports the following limb-darkening laws:

`CONST`
  Constant law, where :math:`I` has no dependence on
  :math:`\mu` whatsoever. This is discussed further below.

`LINEAR`
  Linear law given in equation :math:numref:`eq:linear-law` above.

`SQRT`
  Square-root law introduced by :ads_citet:`diaz-cordoves:1992`.

`QUAD`
  Quadratic law introduced by :ads_citet:`wade:1985`.

`CLARET`
  Four-coefficient law introduced by :ads_citet:`claret:2000`
  and given in equation :math:numref:`eq:claret-law` above.

The choice of law is made during grid construction (see the
:ref:`custom-grids` appendix for more details). The coefficients
appearing in the limb-darkening laws (e.g., :math:`a` and
:math:`a_{k}`) are typically determined from least-squares fits to
tabulations of the specific intensity. In cases where these
tabulations include flux but not specific intensity data, the `CONST`
law is used; the angle-independent specific intensity is determined so
that it produces the correct flux when evaluated using equation
:math:numref:`eq:flux`.

Interpolation in Wavelength
---------------------------

The :math:`\lambda` dependence of the specific intensity is represented
as a piecewise-constant function on a wavelength grid :math:`\lambda =
\{\lambda_{1},\lambda_{2},\ldots,\lambda_{M}\}`:

.. math::

   I(\lambda; \ldots) = I_{i}(\ldots) \qquad \lambda_{i} \leq \lambda < \lambda_{i+1}.

(as before, the ellipses represent the omitted parameters). Mapping
intensity data onto a new grid :math:`\lambda' =
\{\lambda'_{1},\lambda'_{2},\ldots\,\lambda'_{M'}\}` is performed
conservatively, according to the expression

.. math::

   I'_{j}(\ldots) = \frac{\int_{\lambda'_{j}}^{\lambda'_{j+1}} I(\lambda; \ldots) \diff{\lambda}}{\lambda'_{j+1} - \lambda'_{j}}.

Beyond its simplicity, the advantage of this approach (as compared to
higher-order interpolations) is that the equivalent width of line
profiles is preserved.

Interpolation in Atmosphere Parameters
--------------------------------------

The dependence of the specific intensity on atmosphere parameters
(:math:`x, y, z, \ldots`) is represented using cubic tensor product
interpolation. A (relatively) gentle introduction to tensor product
interpolation is provided in an :ref:`Appendix
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

.. _photometric-colors:

Evaluating Photometric Colors
=============================

To evaluate photometric colors, MSG convolves a stellar spectrum with
appropriate photometric response functions (each representing the
combined sensitivity of the optical pathway, filter and the
detector). For a given response function, this convolution can be
performed before or after the interpolations discussed above:

* the 'before' option performs the convolution as a pre-processing
  step to create a photometric grid from a spectroscopic grid (see the
  :ref:`creating-grids` section). This is computationally more
  efficient, but requires that the photometric grid be stored on disk
  separately from the spectroscopic grid.

* the 'after' option performs the convolution on-the-fly after each
  spectrum is interpolated. This is computationally less efficient,
  but incurs no storage requirements beyond the spectroscopic grid.

Disk Storage
============

MSG spectroscopic and photometric grids are stored on disk in `HDF5
<https://www.hdfgroup.org/solutions/hdf5/>`__ files with a bespoke
schema. Because HDF5 is a portable binary format with support for
on-the-fly compression/decompression, it is ideally suited for the
typically large storage requirements of spectral grids.

.. _memory-management:

Memory Management
=================

It's often the case that the data stored in grid files greatly exceed
the available memory (RAM) capacity of one's computer. MSG handles
such situations by loading data into memory only when they are
required. These data are retained in memory until a user-defined
capacity limit reached (see the :py:attr:`SpecGrid.cache_limit` and
:py:attr:`PhotGrid.cache_limit` attributes in the
:ref:`python-interface`, and corresponding functionality in the
:ref:`Fortran <fortran-interface>` and :ref:`C <c-interface>`
interfaces); then, data are evicted from the memory cache via a
:wiki:`least-recently-used` algorithm.

