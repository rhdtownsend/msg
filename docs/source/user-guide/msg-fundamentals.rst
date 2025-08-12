.. _msg-fundamentals:

****************
MSG Fundamentals
****************

This chapter expands on the :ref:`walkthroughs`, by describing in
detail how MSG evaluates stellar spectra and photometric colors. It
also aims to clarify the different concepts that are often
lumped together under the name 'spectrum'.

.. _elem-spectra:

Elemental Spectra
=================

The radiation emitted by a small element of a star's photosphere is most
completely characterized by the specific intensity
:math:`\intsy(\lambda; \vshat; \vx)`. This quantity is defined such
that energy passing through the element into a solid angle
:math:`\diff{\Omega}` oriented along the unit direction vector
:math:`\vshat`, and within wavelength
interval :math:`[\lambda, \lambda+\diff{\lambda}]` and time interval
:math:`\diff{t}`, is

.. math::

   \diff{\engy} =
   \intsy(\lambda; \vshat; \vx) \
   \vshat \cdot \vnhat \
   \diff{\Omega} \,
   \diff{t}\,
   \diff{\lambda} \,
   \diff{\area}.

Here, :math:`\diff{\area}` is the area of the photospheric element,
:math:`\vnhat` is the unit surface normal vector, and :math:`\vx` is a
vector specifying the parameters of the element --- for
instance, its effective temperature :math:`T_{\rm eff}`, gravity
:math:`g` and metallicity :math:`[{\rm Fe}/{\rm H}]`. The subscript on
:math:`\intsy` is a reminder that it is the specific intensity per
unit `wavelength` interval, which is related to the intensity per unit
`frequency` interval by

.. math::

   \intsy(\lambda; \vshat; \vx) = \frac{c}{\lambda^{2}} \intnu(\lambda; \vshat; \vx).

Integrating the equation for :math:`\diff{\engy}` over all solid
angles yields the net energy passing through the element in the
specified wavelength and time intervals:

.. math::
   :label: eq:diff-E

   \engy \equiv
   \int_{\Omega} \diff{\engy} = 
   \flux(\lambda; \vx) \,
   \diff{t} \,
   \diff{\lambda} \,
   \diff{\area},

where the flux is introduced as

.. math::
   :label: eq:elem-flux

   \flux(\lambda; \vx) \equiv \int_{\Omega} \intsy(\lambda; \vshat; \vx) \
   \vshat \cdot \vnhat \ \diff{\Omega}.

Typically the radiation field is axisymmetric around :math:`\vnhat`,
and so :math:`\intsy` depends on direction solely via the angle
parameter :math:`\mu \equiv \vshat \cdot \vnhat`. Then, the flux
simplifies to

.. math::
   :label: eq:elem-flux-axi

   \flux(\lambda; \vx) = 2\pi \int_{0}^{1} \intsy(\lambda; \mu; \vx) \ \mu \ \diff{\mu}

(the lower bound on :math:`\mu` is set to 0 rather than -1 under the
assumption that there is no external radiation at the stellar photosphere).

Both :math:`\intsy` and :math:`\flux` can reasonably be dubbed a
'spectrum', as they each represent a distribution of electromagnetic
energy with respect to wavelength. However, one should be careful to
distinguish these `elemental` spectra from the :ref:`irradiance spectrum
<irrad-spectra>` of a star; this distinction is further clarified below.

Evaluating an elemental spectrum requires solution of the radiative
transfer equation throughout the layers composing the
photosphere. This is often far too computationally expensive to do
on-the-fly. An alternative approach is to pre-calculate spectra across
a multi-dimensional grid spanning a range of photospheric parameters,
and then interpolate within this grid when an elemental spectrum is
required for a specific :math:`\vx`. `This is the fundamental purpose
of MSG.`

Evaluating Elemental Spectra
============================

To evaluate an elemental specific intensity spectrum, MSG models the
dependence of :math:`\intsy(\lambda;\mu;\vx)` on each of its arguments
as follows:

* wavelength dependence is represented using piecewise-constant
  functions.
* angle dependence is represented using limb-darkening laws.
* photospheric parameter dependence is represented using tensor product interpolation.

The following subsections discuss these in greater detail.

Wavelength Dependence
---------------------

The :math:`\lambda` dependence of the specific intensity is
represented as a piecewise-constant function on a wavelength abscissa
:math:`\lambda = \{\lambda_{1},\lambda_{2},\ldots,\lambda_{M}\}`:

.. math::

   \intsy(\lambda) = I_{\lambda,i} \qquad \lambda_{i} \leq \lambda < \lambda_{i+1}.

(for brevity, the dependence of :math:`\intsy` on :math:`\mu` and
:math:`\vx` has been suppressed).  Mapping intensity data onto a new
abscissa :math:`\lambda' =
\{\lambda'_{1},\lambda'_{2},\ldots\,\lambda'_{M'}\}` is performed
conservatively, according to the expression

.. math::

   I'_{\lambda,i} = \frac{\int_{\lambda'_{i}}^{\lambda'_{i+1}} \intsy(\lambda) \diff{\lambda}}{\lambda'_{i+1} - \lambda'_{i}}.

Beyond its simplicity, the advantage of this approach (as compared to
higher-order interpolations) is that the equivalent width of line
profiles is preserved.

Angle Dependence
----------------

The :math:`\mu` dependence of the specific intensity is represented
using limb-darkening laws. Most familiar is the linear law

.. math::
   :label: eq:linear-law

   \frac{\intsy(\mu)}{\intsy(1)} =
   1 - c  \left[1 - \mu\right],

where :math:`\intsy(1)` represents the normally emergent
(:math:`\mu=1`) intensity and :math:`c` is the linear
limb-darkening coefficient (as before, the dependence of the intensity
on other parameters has been suppressed). An improved characterization
involves additional :math:`\mu`-dependent terms on the right-hand
side; for instance, the four-coefficient law devised by
:ads_citet:`claret:2000` is

.. math::
   :label: eq:claret-law

   \frac{\intsy(\mu)}{\intsy(1)} = 1 - \sum_{j=1}^{4} c_{j} \left[1 - \mu^{j/2}\right],

where there are now four limb-darkening coefficients :math:`c_{j}`.

The advantage of using limb-darkening laws is the ease with which
other useful quantities can be calculated. For instance, the flux
:math:numref:`eq:elem-flux-axi` can be evaluated analytically.  So,
too, can the :ads_citet:`eddington:1926` intensity moments
(`E-moments`, as MSG terms them),

.. math::

   \emom(\lambda; \vx) = \frac{1}{2} \int_{0}^{1} \intsy(\lambda; \mu; \vx) \, \mu^{k} \,\diff{\mu},

and the Legendre polynomial moments (`P-moments`) introduced in
:ads_citet:`townsend:2003`,

.. math::

   \pmom(\lambda; \vx) = \int_{0}^{1} \intsy(\lambda; \mu; \vx) \, \mu \, P_{\ell}(\mu) \,\diff{\mu}.

   
.. _limb-darkening-laws:

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
appearing in the limb-darkening laws (e.g., :math:`c` and
:math:`c_{j}`) are typically determined from least-squares fits to
tabulations of the specific intensity at each wavelength. In cases
where these tabulations include flux but not specific intensity data,
the `CONST` law is used; the angle-independent specific intensity is
determined so that it produces the correct flux when evaluated using
equation :math:numref:`eq:elem-flux-axi`.
   
Photospheric Parameter Dependence
---------------------------------

The photospheric parameter dependence of the specific intensity is
represented using cubic Hermite tensor product interpolation. The
appendices provide a :ref:`(relatively) gentle introduction to tensor
product interpolation <tensor-product-interpolation>`. The short
version is that the intensity is modeled via piecewise-cubic functions
of each component of :math:`\vx`, constructed to be continuous and
smooth at the join between each piecewise region. The derivatives at
these joins are estimated using second-order finite difference
approximations involving neighboring points (or first-order at grid
boundaries).

Grids often contain :ref:`voids <grid-voids>` and/or ragged boundaries
(the latter typically arising near the edge of the region of the
:math:`\Teff-g` plane corresponding to super-Eddington
luminosity). When an interpolation tries to access such missing data,
MSG signals an exception (see the :ref:`exception-handling` chapter
for further details).

.. _irrad-spectra:

Irradiance Spectra
==================

Suppose a star is observed from a distance :math:`d`\ [#distant]_
along unit direction vector :math:`\vdhat` (pointing from star to
observer). The energy measured by a detector of area
:math:`\diff{\areao}`, within wavelength interval :math:`[\lambda,
\lambda+\diff{\lambda}]` and time interval :math:`\diff{t}`, can be
expressed as

.. math::

   \engyo =
   \irrad(\lambda) \,
   \diff{t} \,
   \diff{\lambda} \,
   \diff{\areao}

(here and subsequently the superscript :math:`^{\obs}` should be read
as 'observed'), where the `irradiance` is introduced as

.. math::
   :label: eq:irrad
   
   \irrad(\lambda) \equiv \frac{1}{d^{2}}
   \int_{\text{disk}} \intsy(\lambda; \vdhat; \vx) \, \vdhat \cdot \vnhat \, \diff{\area}.

The integral is over the stellar disk (i.e., the visible area of the
photosphere). The irradiance has the same units as the elemental flux
[cf. equation :math:numref:`eq:elem-flux`], and confusingly is often
referred to as the 'flux'. However, the two quantities are defined at
different locations: the irradiance at the observer's location, the
elemental flux at the stellar photosphere. It is the irradiance that
is measured by a telescope/spectrograph.

Under certain conditions, a simple proportionality relationship exists
between irradiance and elemental flux. Consider a star that is
spherically symmetric and has spatially uniform photospheric
parameters. Then, the specific intensity must be axisymmetric around
:math:`\vnhat`, and moreover cannot depend on location on the
surface. Let :math:`\theta` be the colatitude angle in a spherical
coordinate system centered on the star and with polar axis parallel to
:math:`\vdhat`. Setting :math:`\vdhat \cdot \vnhat = \cos\theta =
\mu`, the irradiance can be reduced to

.. math::
   :label: eq:irrad-reduce

   \irrad(\lambda) =
   \frac{2 \pi R^{2}}{d^{2}} \int_{0}^{1} \intsy(\lambda; \mu; \vx) \, \mu \, \diff{\mu}.

Comparing this expression against equation
:math:numref:`eq:elem-flux-axi`, it is evident that

.. math::
   :label: eq:irrad-flux

   \irrad(\lambda) = \frac{R^{2}}{d^{2}} \flux(\lambda; \vx).

This is a very convenient result: it means that we need only the
elemental flux spectrum, and not the specific intensity, to calculate
the irradiance. That's why many spectral grids in the literature
include flux spectra instead of specific intensity spectra.

However, recall that equation :math:numref:`eq:irrad-flux` applies
only to spherically symmetric, uniform stars. In more complex
situations, for instance when the star is rotating, spotted, pulsating
or even eclipsed, evaluation of :math:`\irrad` must proceed via the
disk integration appearing in equation :math:numref:`eq:irrad`, which
requires the specific intensity.

.. _photometric-colors:

Photometric Colors
==================

To evaluate a photometric color, MSG convolves spectra with an
appropriate passband response function :math:`S'(\lambda)`. This
function represents the combined sensitivity of the optical pathway,
filter, and detector. The photometric specific intensity is defined as

.. math::
   :label: eq:conv

   \mintsy(\vshat; \vx) = \int_{0}^{\infty}
   \intsy(\lambda; \vshat; \vx) S'(\lambda) \diff{\lambda}
   \left/ \int_{0}^{\infty} S'(\lambda) \diff{\lambda} \right.,

meaning that :math:`S'(\lambda)` is interpreted as an `energy`
response function (see appendix A of :ads_citealp:`bessell:2012` for a
discussion of the relationship between :math:`S'` and the
corresponding photon response function :math:`S`). The photometric
irradiance then follows from equation :math:numref:`eq:irrad` as

.. math::

   \mirrad = \frac{1}{d^{2}}
   \int_{\text{disk}} \mintsy(\vdhat; \vx) \, \vdhat \cdot \vnhat \, \diff{\area},
   
and the apparent magnitude of the star in the adopted photometric system is

.. math::

   m = -2.5 \log \left( \frac{\mirrad}{\fluxz} \right),

where :math:`\fluxz` is the zero-point flux of the system.

.. rubric:: Footnotes

.. [#distant] The analysis here assumes that the distance to the
               center of the star is very large compared to its
               physical size, such that all parts of the photosphere
               can be treated as if they were at the same distance
               :math:`d` from the observer. This also allows the use
               of the small-angle approximation.
