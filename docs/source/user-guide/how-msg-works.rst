.. _how-msg-works:

*************
How MSG Works
*************

This chapter expands on the :ref:`Python <python-walkthrough>`,
:ref:`Fortran <fortran-walkthrough>` and :ref:`C <c-walkthrough>`
walkthroughs, by describing in detail how MSG evaluates stellar
spectra and photometric colors.

Evaluating a Spectrum
=====================

To evaluate a spectrum, MSG interpolates in a grid of pre-calculated
spectroscopic data. Focusing on specific intensity evaluation, this
involves constructing a (preferably continuous and smooth) function

.. math::

   I_{\lambda}(\mu; \lambda; x, y, z, \ldots)

representing the intensity (in units of
:math:`\erg\,\cm^{-2}\,\second^{-1}\,\angstrom^{-1}\,\sterad^{-1}`)
emerging at direction cosine :math:`\mu` and wavelength
:math:`\lambda` from an atmosphere characterized by a set of :math:`N`
parameters :math:`x, y, z, \ldots` (which can correspond to quantities
such as effective temperature :math:`T_{\rm eff}`, gravity :math:`g`,
etc.).

.. _limb-darkening-laws:

Limb-Darkening Laws
-------------------

The :math:`\mu` dependence of the specific intensity is represented
using limb-darkening laws. The simplest and most well known is the linear law

.. math::
   :label: eq:linear-law

   \frac{I_{\lambda}(\mu; \ldots)}{I_{\lambda}(1; \ldots)} =
   1 - a (\ldots) \left[1 - \mu\right]

where :math:`I_{\lambda}(1; \ldots)` represents the normally emergent
(:math:`\mu=1`) intensity and :math:`a(\ldots)` is the linear
limb-darkening coefficient (here the ellipses :math:`\ldots` represent
the other parameters, which have been omitted for brevity). A better
characterization involves introducing additional :math:`\mu`-dependent
terms on the right-hand side; for instance, the four-coefficient law
devised by :ads_citet:`claret:2000` is

.. math::
   :label: eq:claret-law

   \frac{I_{\lambda}(\mu; \ldots)}{I_{\lambda}(1, \ldots)} = 1 - \sum_{k=1}^{4} a_{k}(\ldots) \left[1 - \mu^{k/2}\right],

where there are now four limb-darkening coefficients :math:`a_{k}(\ldots)`.

The advantage of using limb-darkening laws is the ease with which
other useful quantities can be calculated. For instance, the emergent
flux

.. math::
   :label: eq:flux

   F_{\lambda}(\ldots) = \int_{0}^{1} I_{\lambda}(\mu; \ldots) \, \mu \, \diff\mu

can be evaluated analytically, as can any of the
:ads_citet:`eddington:1926` intensity moments (or `E-moments`, as MSG
terms them):

.. math::

   \mathcal{E}^{i}_{\lambda}(\ldots) = \frac{1}{2} \int_{0}^{1} I_{\lambda}(\mu; \ldots) \, \mu^{i} \,\diff\mu.

MSG supports the following limb-darkening laws:

`CONST`
  Constant law, where :math:`I_{\lambda}` has no dependence on
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
:ref:`grid-tools` appendix for more details). The coefficients
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
as a piecewise-constant function on a wavelength abscissa :math:`\lambda =
\{\lambda_{1},\lambda_{2},\ldots,\lambda_{M}\}`:

.. math::

   I_{\lambda}(\lambda; \ldots) = I_{i}(\ldots) \qquad \lambda_{i} \leq \lambda < \lambda_{i+1}.

(as before, the ellipses represent the omitted parameters). Mapping
intensity data onto a new abscissa :math:`\lambda' =
\{\lambda'_{1},\lambda'_{2},\ldots\,\lambda'_{M'}\}` is performed
conservatively, according to the expression

.. math::

   I'_{i}(\ldots) = \frac{\int_{\lambda'_{i}}^{\lambda'_{i+1}} I_{\lambda}(\lambda; \ldots) \diff{\lambda}}{\lambda'_{i+1} - \lambda'_{i}}.

Beyond its simplicity, the advantage of this approach (as compared to
higher-order interpolations) is that the equivalent width of line
profiles is preserved.

Interpolation in Atmosphere Parameters
--------------------------------------

The dependence of the specific intensity on atmosphere parameters
(:math:`x, y, z, \ldots`) is represented using cubic tensor product
interpolation. The appendices provide a :ref:`(relatively) gentle
introduction to tensor product interpolation
<tensor-product-interpolation>`. The short version is that intensity,
flux, etc. are represented as piecewise-cubic functions `in each
atmosphere parameter`, constructed to be continuous and smooth at the
join between each piecewise region.

Grids often contain holes and/or ragged boundaries (the latter
typically arising near the edge of the region of the :math:`T_{\rm
eff}-g` plane corresponding to super-Eddington
luminosity). When an interpolation tries to access such missing data,
MSG either switches to a lower-order scheme, or (if there simply
aren't sufficient data to interpolate) returns with an error (see the
:ref:`exception-handling` section below).

.. _photometric-colors:

Evaluating Photometric Colors
=============================

To evaluate a photometric color, MSG convolves a stellar spectrum with
appropriate passband response function :math:`S'(\lambda)`. This
function represents the combined sensitivity of the optical pathway,
filter and the detector. The mean flux in the passband is evaluated as

.. math::
   :label: eq:conv

   \langle F \rangle = \frac{\int_{0}^{\infty} F_{\lambda}(\lambda) S'(\lambda) \diff{\lambda}}{\int_{0}^{\infty} S'(\lambda) \diff{\lambda}},

...meaning that :math:`S'(\lambda)` is interpreted as an `energy`
response function (see appendix A of :ads_citealp:`bessell:2012` for a
discussion of the relationship between :math:`S'` and the
corresponding photon response function :math:`S`). The apparent
magnitude at the location where :math:`\langle F \rangle` is measured
follows as

.. math::

   m = -2.5 \log_{10} \left\langle \frac{F}{F_{0}} \right\rangle,

where the normalizing flux :math:`F_{0}` is determined by the
zero-point of the photometric system.

For a given response function, the convolution :math:numref:`eq:conv` can be
performed before or after the interpolations discussed above:

* the 'before' option performs the convolution as a pre-processing
  step using the :command:`specgrid_to_photgrid` tool to create a
  `photgrid` file from a `specgrid` file (as discussed in the
  :ref:`creating-photgrids` section). This is computationally more
  efficient, but requires a separate `photgrid` file to be created for
  each passband.

* the 'after' option loads data from a `specgrid` file, but performs
  the convolution on-the-fly after each spectrum is interpolated. This
  is computationally less efficient, but incurs no storage
  requirements beyond the `specgrid` file.
  
