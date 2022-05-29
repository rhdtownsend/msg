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

Disk Storage
============

MSG spectroscopic and photometric grid data are stored on disk in
`HDF5 <https://www.hdfgroup.org/solutions/hdf5/>`__ files with a
bespoke schema. Throughout this documentation, these files are known
as `specgrid` and `photgrid` files, respectively.

.. _memory-management:

Memory Management
=================

It's often the case that the data stored in `specgrid` and `photgrid`
files greatly exceed the available computer memory (RAM). MSG handles
such situations by loading data into memory only when they are
required. These data are retained in memory until a user-defined
capacity limit reached (see the :py:attr:`SpecGrid.cache_limit
<pymsg.SpecGrid.cache_limit>` and :py:attr:`PhotGrid.cache_limit
<pymsg.PhotGrid.cache_limit>` properties in the
:ref:`python-interface`, and corresponding functionality in the
:ref:`Fortran <fortran-interface>` and :ref:`C <c-interface>`
interfaces); then, data are evicted from the memory cache via a
:wiki:`least recently used
<Cache_replacement_policies#Least_recently_used_(LRU)>`
algorithm.


.. _photometric-colors:

Evaluating Photometric Colors
=============================

To evaluate photometric colors, MSG convolves a stellar spectrum with
appropriate passband response functions. For a given response
function, this convolution can be performed before or after the
interpolations discussed above:

* the 'before' option performs the convolution as a pre-processing
  step to create a `photgrid` file from a `specgrid` file (as
  discussed in the :ref:`creating-photgrids` section). This is
  computationally more efficient, but requires a separate `photgrid`
  file for each passband.

* the 'after' option performs the convolution on-the-fly after each
  spectrum is interpolated. This is computationally less efficient,
  but incurs no storage requirements beyond the `specgrid` file.

.. _exception-handling:
  
Exception Handling
==================

When a call to an MSG routine encounters a problem, the course of
action depends on which langauge is being used:

* In Python, an exception is thrown with a (reasonably) relevant
  subtype and error message.

* In Fortran, if the optional integer argument :f:var:`stat` is present
  during the call, then on return :f:var:`stat` is set to an value
  indicating the nature of the problem (see the :ref:`fortran-params`
  chapter for the list of possible values). If :f:var:`stat`
  is not present, then execution halts with an error message
  printed to standard output.

* In C, if the pointer argument :c:var:`stat` is non-null during the
  call, then on return the target of :c:var:`stat` is set to a value
  indicating the nature of the problem (see the :ref:`c-enums` chapter
  for the list of possible values). If :c:var:`stat` is null, then
  execution halts with an error message printed to standard output.

