.. _fundamentals:

************
Fundamentals
************

This chapter discusses the fundamentals of MSG: what it does and how
it works.

Spectral Representation
=======================

MSG represents the wavelength dependence of spectral quantities such
as specific intensity or flux density, as piecewise-constant
functions. A wavelength abscissa :math:`\{\lambda_{i}\}`
(:math:`i=1,2,\ldots`) defines the intervals over which the spectral
quantities are constant. Thus, for instance, the flux density
:math:`F_{\lambda}` is expressed as

.. math::

   F_{\lambda} = F_{i} \qquad (\lambda_{i} \leq \lambda < \lambda_{i+1}),

where :math:`\{F_{i}\}` does not depend on wavelength. This approach
mirrors how spectra are recorded in dispersed spectrographs (where
photons are collected in spatially discrete bins such as pixels).

To map from one wavelength abscissa to another, MSG applies an
algorithm that conserves energy and equivalent width. Specifically, on
a new wavelength abscissa :math:`\lambda'_{j}`, the flux density
values become

.. math::

   F'_{j} = \frac{1}{\lambda'_{j+1} - \lambda'_{j}} \int_{\lambda'_{j}}^{\lambda'_{j+1}} F_{\lambda} \,\diff\lambda.

Limb Darkening
==============

MSG handles limb darkening by representing the angle dependence of the
specific intensity :math:`I_{\lambda}` with parametric models of the
form

.. math::

   I_{\lambda} (\mu) = \sum_{i=1}^{N} c_{i;\lambda} b_{i}(\mu).

Here, :math:`c_{\lambda;i}` (:math:`i=1,2,\ldots,N`) are a set of
wavelength-dependent coefficients, :math:`b_{i}(\mu)` are a set of
basis functions, and :math:`\mu \equiv \cos\theta`. In this form, the
canonical linear limb darkening law first introduced by
:ads_citet:`milne:1921`,

.. math::

   I_{\lambda} (\mu) = I(1) \left[ 1 - u_{\lambda} (1 - \mu) \right],

can be represented with the basis functions

.. math::

   b_{1} = 1, \qquad b_{2} = - (1 - \mu)

and the coefficients

.. math::

   c_{\lambda;1} = I_{\lambda}(1), \qquad c_{\lambda;2} = I_{\lambda}(1) \, u_{\lambda}.

However, MSG can also handle more-complex laws, such as the
square-root law :ads_citep:`diaz-cordoves:1992` and the 4-coefficient law
introduced by :ads_citet:`claret:2000`.

Typically, stellar atmosphere codes tabulate the specific intensity at
a set number of angle parameters $\mu=\mu_{1},\mu_{2},\ldots$. To
determine the coefficients :math:`c_{\lambda;i}` from these data, MSG
performs a least-squared minimization on the function
:math:`y(\mu) = 1 - I(\mu)/I(1)`, constrained so that
:math:`y(1) = 0`.

Fluxes & Moments
================

Rather than storing separate data for the specific intensity and flux
density, MSG derives the latter from the former via the standard
relation

.. math::

   F_{\lambda} \equiv \int_{0}^{1} I_{\lambda}(\mu) \mu \,\diff{\mu}.

This is evaluated by analytically integrating the parametric
limb-darkening model.

MSG uses a similar approach to evaluate the :math:`\mathcal{E}`
(Eddington) moments

.. math::

   \mathcal{E}_{k;\lambda} \equiv \frac{1}{2} \int_{0}^{1} \mu^{k} I_{\lambda}(\mu) \,\diff{\mu}

(:math:`k \geq 0`) and the :math:`\mathcal{D}` (differential flux
function) moments

.. math::

   \mathcal{D}_{\ell;\lambda} \equiv \int_{0}^{1} \mu P_{\ell}(\mu) I_{\lambda}(\mu) \,\diff{\mu}

introduced by :ads_citet:`townsend:2003` (and labelled as
:math:`I_{\ell;\lambda}` therin).


Interpolation in Parameters
===========================

To interpolate across atmosphere parameters (e.g., effective temoperature,
metallicity), MSG uses tensor outer product surfaces.


Load-On-Demand
==============

For performance reasons, when MSG loads a spectral grid it doesn't
read all of the data into memory at once. Rather, data are loaded on
demand.
