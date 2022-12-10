.. _msg-fundamentals:

****************
MSG Fundamentals
****************

This chapter expands on the :ref:`walkthroughs`, by describing in
detail how MSG evaluates stellar spectra and photometric colors. The
first couple of sections serve to clarify the variety of different
concepts that are often lumped together under the name 'spectrum'.

.. _elem-spectra:

Elemental Spectra
=================

The radiation emitted by a small element of a star's surface is most
completely characterized by the specific intensity
:math:`\intsy(\lambda; \vshat; \vx)`. This quantity is defined such
that energy passing through the element into a solid angle
:math:`\diff{\Omega}` oriented along the unit direction vector
:math:`\vshat`, and within wavelength
interval :math:`[\lambda, \lambda+\diff{\lambda}]` and time interval
:math:`\diff{t}`, is

.. math::

   \diff{\engy} =
   \intsy(\lambda; \vshat; \vx) \, \vshat \cdot \vnhat \,
   \diff{\Omega} \,
   \diff{\lambda} \,
   \diff{t} \,
   \diff{\area}.

Here, :math:`\diff{\area}` is the area of the surface element,
:math:`\vnhat` is the unit surface normal vector, and :math:`\vx` is a
vector specifying the photospheric parameters of the element --- for
instance, its effective temperature :math:`T_{\rm eff}` and gravity
:math:`g`. Integrating this equation over all solid angles yields the
net energy passing through the element in the wavelength and time
intervals:

.. math::
   :label: eq:diff-E

   \engy =
   \flux(\lambda; \vx) \,
   \diff{t} \,
   \diff{A},

where the flux is introduced as

.. math::
   :label: eq:elem-flux

   \flux(\lambda; \vx) \equiv \int \intsy(\lambda; \vshat; \vx) \, \vshat \cdot \vnhat \, \diff{\Omega}.

Typically the radiation field is axisymmetric around :math:`\vnhat`,
and so :math:`\intsy` depends on direction solely via the angle
parameter :math:`\mu \equiv \vshat \cdot \vnhat`. Then, the flux
simplifies to

.. math::
   :label: eq:elem-flux-axi

   \flux(\lambda; \vx) = 2\pi \int_{0}^{1} \intsy(\lambda; \mu; \vx) \, \mu \, \diff{\mu}

(the lower bound on :math:`\mu` is set to 0 rather than -1 under the
assumption that there is no external radiation at the stellar surface).

Both :math:`\intsy` and :math:`\flux` can reasonably be dubbed a
'spectrum', as they each represent the distribution of electromagnetic
energy with respect to wavelength. However, one should be careful to
distinguish these `elemental` spectra from the :ref:`observed spectrum
<obs-spectra>` of a star; this distinction is further clarified below.

Evaluating an elemental spectrum requires solution of the radiative
transfer equation throughout the atmospheric layers composing the
surface element. This is typically far too computationally expensive
to do on-the-fly. An alternative approach is to pre-calculate spectra
across a multi-dimensional grid spanning a range of photospheric
parameters, and then interpolate within this grid when an elemental
spectrum is required for a specific :math:`\vx`. `This is the
fundamental purpose of MSG.`

Evaluating Elemental Spectra
============================

To evaluate an elemental specific intensity spectrum, MSG mdoels the
dependence of :math:`\intsy` on each of its three arguments as follows:

* Wavelength dependence is represented using piecewise-constant
  functions.
* Angle dependence is represented using limb-darkening laws.
* Photosphere parameter dependence is represented using tensor surface
  interpolation.

The following subsections discuss these in greater detail.

Wavelength Dependence
---------------------

The :math:`\lambda` dependence of the specific intensity is
represented as a piecewise-constant function on a wavelength abscissa
:math:`\lambda = \{\lambda_{1},\lambda_{2},\ldots,\lambda_{M}\}`:

.. math::

   \intsy(\lambda) = I_{i} \qquad \lambda_{i} \leq \lambda < \lambda_{i+1}.

(for brevity, the dependence of :math:`\intsy` on :math:`\mu` and
:math:`\vx` has been suppressed).  Mapping intensity data onto a new
abscissa :math:`\lambda' =
\{\lambda'_{1},\lambda'_{2},\ldots\,\lambda'_{M'}\}` is performed
conservatively, according to the expression

.. math::

   I'_{i} = \frac{\int_{\lambda'_{i}}^{\lambda'_{i+1}} \intsy(\lambda) \diff{\lambda}}{\lambda'_{i+1} - \lambda'_{i}}.

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
   1 - c  \left[1 - \mu\right]

where :math:`\intsy(1)` represents the normally emergent
(:math:`\mu=1`) intensity and :math:`c` is the linear
limb-darkening coefficient (as before, the dependence of the intensity
on other parameters has been suppressed). An improved characterization
involves additional :math:`\mu`-dependent terms on the right-hand
side; for instance, the four-coefficient law devised by
:ads_citet:`claret:2000` is

.. math::
   :label: eq:claret-law

   \frac{\intsy(\mu)}{\intsy(1)} = 1 - \sum_{k=1}^{4} c_{k} \left[1 - \mu^{k/2}\right],

where there are now four limb-darkening coefficients :math:`c_{k}`.

The advantage of using limb-darkening laws is the ease with which
other useful quantities can be calculated. For instance, the flux
:math:numref:`eq:elem-flux-axi` can be evaluated analytically, as can any
of the :ads_citet:`eddington:1926` intensity moments (or `E-moments`,
as MSG terms them):

.. math::

   \mathcal{E}^{i}_{\lambda}(\lambda; \vx) = \frac{1}{2} \int_{-1}^{1} \intsy(\lambda; \mu; \vx) \, \mu^{i} \,\diff{\mu}.

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
:math:`c_{k}`) are typically determined from least-squares fits to
tabulations of the specific intensity. In cases where these
tabulations include flux but not specific intensity data, the `CONST`
law is used; the angle-independent specific intensity is determined so
that it produces the correct flux when evaluated using equation
:math:numref:`eq:elem-flux-axi`.
   
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
approximations involving neighboring points (or first order at grid
boundaries).

Grids often contain holes and/or ragged boundaries (the latter
typically arising near the edge of the region of the :math:`\Teff-g`
plane corresponding to super-Eddington luminosity). When an
interpolation tries to access such missing data, MSG either switches
to a lower-order scheme, or (if there simply aren't sufficient data to
interpolate) signals an exception (see the :ref:`exception-handling`
chapter for further details).

.. _obs-spectra:

Observed Spectra
================

Suppose we observe a star from Earth, at a distance :math:`d` along
unit direction vector :math:`\vdhat`. The energy measured by a
detector of area :math:`\areao`, within the usual wavelength and time
intervals, is

.. math::

   \engyo =
   \fluxo(\lambda) \,
   \diff{t} \,
   \areao

(here and subsequetly the superscript :math:`^{\obs}` should be read
as 'observed'), where the observed flux is introduced as

.. math::
   :label: eq:obs-flux
   
   \fluxo(\lambda) \equiv \frac{1}{d^{2}}
   \int_{\text{vis.}} \intsy(\lambda; -\vdhat; \vx) \, [-\vdhat \cdot \vnhat] \, \diff{\area}.

The integral here is similar to that in equation
:math:numref:`eq:elem-flux`, but :math:`\vshat` has been replaced by
:math:`-\vdhat`, the solid angle element :math:`\diff{\Omega}` has
been replaced by :math:`\diff{\area}/d^{2}`, and the bounds of the
integral are limited to the parts of the stellar surface that are
visible from Earth.

For stars that are spherical and have a uniform :math:`\vx` across
their surface, further simplifications can be made. Let :math:`\theta`
and :math:`\phi` be the colatitude and azimuth angles in a spherical
coordinate system centered on the star and with polar axis
antiparallel to :math:`\vdhat`. Then, the observed flux becomes

.. math::

   \fluxo(\lambda) =
   \frac{R^{2}}{d^{2}} \int_{0}^{2\pi} \int_{0}^{\pi/2} \intsy(\lambda; -\vdhat; \vx) \, \cos\theta \, \sin\theta \, \diff{\theta} \, \diff{\phi},

where :math:`R` is the stellar radius. Assuming an axisymmetric
radiation field, this further reduces to

.. math::

   \fluxo(\lambda) =
   2 \pi \frac{R^{2}}{d^{2}} \int_{0}^{\pi/2} \intsy(\lambda; \cos\theta; \vx) \, \cos\theta \, \sin\theta \, \diff{\theta}.

With the substitution :math:`\mu = \cos\theta`, the result pops out that

.. math::
   :label: eq:obs-flux-elem

   \fluxo(\lambda) = \frac{R^{2}}{d^{2}} \flux(\lambda; \vx).

Don't be fooled by the apparent triviality of this result: it means
that we need only the elemental flux spectrum, and not the specific
intensity, to calculate the observed spectrum of a star. This is why
many spectral grids in the literature include flux spectra instead of
specific intensity spectra.

However, remember that equation :math:numref:`eq:obs-flux-elem`
applies only for spherically symmetric and uniform-surface stars. In
more complex situations, for instance when a star is rotationally
oblate, spotted, pulsating or even eclipsed, evaluation of
:math:`\fluxo` must proceed via the visible-disk integration appearing
in equation :math:numref:`eq:obs-flux`, which requires the specific
intensity.


.. _photometric-colors:

Photometric Colors
==================

To evaluate a photometric color, MSG convolves stellar spectra with an
appropriate passband response function :math:`S'(\lambda)`. This
function represents the combined sensitivity of the optical pathway,
filter and detector. The passband-averaged specific intensity is
defined as

.. math::
   :label: eq:conv

   \mintsy(\vshat; \vx) = \int_{0}^{\infty} \intsy(\lambda; \vshat; \vx) S'(\lambda) \diff{\lambda} \left/ \int_{0}^{\infty} S'(\lambda) \diff{\lambda} \right.,

meaning that :math:`S'(\lambda)` is interpreted as an `energy`
response function (see appendix A of :ads_citealp:`bessell:2012` for a
discussion of the relationship between :math:`S'` and the
corresponding photon response function :math:`S`). The passband-averaged observed flux
follows from equation :math:numref:`eq:obs-flux` as

.. math::

   \mfluxo = \frac{1}{d^{2}}
   \int_{\text{vis.}} \mintsy(-\vdhat; \vx) \, [-\vdhat \cdot \vnhat] \, \diff{A},
   
and the apparent magnitude of the star is

.. math::

   m = -2.5 \log_{10} \left( \frac{\mfluxo}{\fluxz} \right),

where the normalizing flux :math:`\fluxz` is set by the zero-point of
the photometric system.

The convolution in :math:numref:`eq:conv` can be performed before or
after the interpolations discussed above:

* the 'before' option performs the convolution as a pre-processing
  step using the :command:`specgrid_to_photgrid` tool to create a
  :f-schema:`photgrid` file from a :f-schema:`specgrid` file (as
  discussed in the :ref:`data-files-importing` section). This is
  computationally more efficient, but requires a separate
  :f-schema:`photgrid` file to be created for each passband.

* the 'after' option loads data from a :f-schema:`specgrid` file, but
  performs the convolution on-the-fly after each spectrum is
  interpolated. This is computationally less efficient, but incurs no
  storage requirements beyond the :f-schema:`specgrid` file.
  
