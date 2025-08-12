.. _grid-voids:

**********
Grid Voids
**********

This chapter explains the causes and workarounds for 'voids' ---
regions of the photospheric parameter space spanned by a grid where MSG
is unable to perform an interpolation. Attempts to interpolate in a
void result in a :f:var:`STAT_UNAVAILABLE_DATA` status code (Fortran and C),
or a :py:exc:`LookupError` exception (Python).

Causes of Voids
===============

MSG's :ref:`tensor-product-interpolation` algorithm divides an
:math:`N`-dimensional grid into cells. Each cell is an
:math:`N`-dimensional :wiki:`hyperrectangle <Hyperrectangle>`; in one
dimension, this is a line segment, in two a rectangle, and so on. To
perform an interpolation in a given cell, MSG requires that all
:math:`2^{N}` vertices (corners) of the cell have a spectral (or
photometric) data associated with them. If this isn't the case, the
cell cannot be used for interpolation, and is considered a
void.

The Eddington Limit
-------------------

Most spectral synthesis codes require that the underlying model
atmosphere remains in hydrostatic equilibrium. This in turn requires
that the outward radiative acceleration in the atmosphere,

.. math::

   \grad = \frac{\kappa_{F} F}{c},

be less than the inward gravitational acceleration :math:`g`. Here,
:math:`F` is the bolometric flux, :math:`c` is the speed of light, and

.. math::

   \kappa_{F} \equiv \frac{1}{F}\int_{0}^{\infty} \kappa \flux \diff{\lambda}

is the flux-weighted mean of the opacity :math:`\kappa`. Recall that
the effective temperature :math:`\Teff` is defined in terms of the
bolometric flux by

.. math::

   F = \sigma \Teff^{4},

where :math:`\sigma` is the Stefan-Boltzmann constant. The condition
for hydrostatic equilibrium can then be expressed as

.. math::
   :label: eq:edd-limit

   \Gamma < 1,

where

.. math::

   \Gamma \equiv \frac{\kappa_{F} \sigma \Teff^{4}}{g c}

is the so-called Eddington factor. Violation of this inequality is a
principal reason why grids lack data (and therefore have voids) at the
high-:math:`\Teff`, low-:math:`g` region of photospheric parameter
space.

Convergence Limits
------------------

Although the Eddington limit :math:numref:`eq:edd-limit` places a hard
lower bound on the surface gravity at a given effective temperature,
in practice the actual lower bound is somewhat larger. This is because
spectral synthesis codes tend to have difficulty converging to
solutions that are close to the limit.

Convergence can also prove difficult in extreme parts of photospheric
parameters space --- for instance, at the highest or lowest
metallicities. In some cases the resulting voids can be filled in with
manual intervention (e.g., by tweaking numerical parameters of the
synthesis code); but often this would be too time consuming, and the
end-users of the grid (us!) have to cope as best we can.

Parameter Adjustment
====================

One approach to mitigating the impact of voids is to adjust photospheric
parameters until they fall within a defined part of the
grid. Typically, one hopes that the adjustment has only a small effect
on the resulting interpolated spectrum.

MSG provides routines to help with this adjustment; for spectral
grids, these are :py:func:`pymsg.SpecGrid.adjust_x` (Python),
:f:func:`~fmsg_m/specgrid_t%adjust` (Fortran), and
:c:func:`adjust_specgrid_x_vec` (C). These all accept a starting set
of photospheric parameters and a direction to adjust in. The following
Python code, which uses the demo grid, demonstrates how one might
handle grid voids by adjusting parameters in the direction of
increasing :math:`g`.

.. literalinclude:: grid-voids/adjust_x.py
   :language: python
