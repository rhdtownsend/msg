.. _spectral-abscissa:

*********************
The Spectral Abscissa
*********************

As briefly reviewed in the :ref:`python-walkthrough` chapter, MSG uses
three parameters --- ``w_0``, ``dw`` and ``n_w`` --- to define the
abscissa of spectra. This chapter explains the rationale for this
choice.

Bin-Averaged Spectra
====================

The flux density is a function :math:`F_{\lambda}` defined such that
the energy :math:`\Delta E_{\rm a,b}` passing through area
:math:`\Delta A` in time :math:`\Delta t`, and within the wavelength
bin :math:`[\lambda_{\rm a},\lambda_{\rm b}]`, is

.. math::

   \Delta E_{\rm a,b} =
   \Delta A \, \Delta t \, \int_{\lambda_{\rm a}}^{\lambda_{\rm b}} F_{\lambda} \,{\rm d}\lambda.

When we measure a spectrum, we may imagine we're determining
:math:`F_{\lambda}` --- but that's only true in a fuzzy sense. In
fact, the detector in a spectrograph (or some related instrument)
measures :math:`\Delta E_{\rm a,b}`, and from that we infer a
bin-average flux density

.. math::

   \left\langle F_{\lambda} \right\rangle_{\rm a,b} =
   \frac{\int_{\lambda_{\rm a}}^{\lambda_{\rm b}} F_{\lambda} \,{\rm d}\lambda}{\Delta \lambda_{\rm a,b}} =
   \frac{\Delta E_{\rm a,b}}{\Delta A \, \Delta t \, \Delta \lambda_{\rm a,b}},

where

.. math::

   \Delta \lambda_{\rm a,b} \equiv \lambda_{\rm b} - \lambda_{\rm a}.

We can generalize this analysis to a spectral abscissa
:math:`\{\lambda_{k}\}` (:math:`k = 1,2,\ldots`) and a corresponding
set of bin-averaged flux densities :math:`\{\left\langle F_{\lambda}
\right\rangle_{k,k+1}\}`, where

.. math::

   \left\langle F_{\lambda} \right\rangle_{k,k+1} = 
   \frac{\Delta E_{k,k+1}}{\Delta A \, \Delta t \, \Delta \lambda_{k,k+1}}.

Together, the abscissa and bin-averaged flux density data are what we term
a `spectrum`.

Uniform Abscissa
================

Often, it's necessary to determine which bin a given wavelength
:math:`\lambda` falls in; that is, determine :math:`j` such that

.. math:: \lambda_{j} \leq \lambda \leq \lambda_{j+1}

If there are a total of :math:`N` bins, then the computational cost of
this search scales as :math:`\log_{2}(N)` --- not too
expensive. `However`, the memory access pattern is non-contiguous,
leading to many cache misses that can slow things down considerably.

A simple solution is to adopt a uniformly spaced abscissa, so that

.. math:: \lambda_{k} = \lambda_{1} + (k-1) \Delta \lambda \qquad (k = 2,3,\ldots N),

where the bin width :math:`\Delta \lambda` is independent of
:math:`k`. Then, :math:`j` can be determined analytically via

.. math:: j = \floor \left( \frac{\lambda - \lambda_{1}}{\Delta \lambda} \right) + 1.

Logarithmic Abscissa
====================

As soon as we allow for motion of the detector relative to the
source, the resulting Doppler shift means that the detector measures a
spectrum on an abscissa :math:`\{\lambda'_{k}\}`, where

.. math::

   \lambda'_{k} = (1 + z) \lambda_{k} = (1 + z) \lambda_{1} + (k - 1) \Delta \lambda (1 + k)
   
From this expression, we see that the bin width for the detector is
different than for the source. This means that we have to perform an
expensive rebinning to map the source output onto the detector.
   

