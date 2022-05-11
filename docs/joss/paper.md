---
title: 'MSG: A package for interpolating in grids of spectra'
tags:
  - Python
  - Fortran
  - C
  - astronomy
  - spectra
  - stars
authors:
  - name: Rich Townsend
    orcid: 0000-0002-2522-8605
    email: townsend@astro.wisc.edu
    affiliation: 1
  - name: Aaron Lopez
    email: alopez@astro.wisc.edu
    affiliation: 1
affiliations:
 - name: Department of Astronomy, University of Wisconsin-Madison, USA
   index: 1
date: 9 May 2022
bibliography: paper.bib

---

# Summary

While the spectrum of the light emitted by a star can be calculated by
simulating the flow of radiation through each layer of the star's
atmosphere, this process is exceedingly computationally expensive.
Therefore, a standard approach is to pre-calculate spectra over a
large grid of atmospheric parameters, and then interpolate within this
grid.

# Statement of Need

`MSG` (short for Multidimensional Spectral Grids) is a software
package for interpolating spectra in pre-calculated grids. There
already exists a small ecosystem of packages providing spectral
interpolation as part of their functionality --- see, for instance,
iSPEC [@Blanco-Cuaresma:2014] and FERRE
[@Allende-Prieto:2015]. However, these offer only a subset of the
desirable features of a modern interpolation package:

* Support for grids with an arbitrary number of dimensions.

* Support for grids with irregularities (missing data, non-uniform grid spacing, etc).

* Support for grids whose size can exceed available RAM.

* Smooth ($C^1$-continuous) interpolation in each dimension (see @Meszaros:2013 for a
  discussion of why this is important).

* Parallel execution to take advantage of multiple processor cores.

* Stand-alone architecture with interfaces in languages commonly adopted in
  the Astronomy community.

MSG provides all of these features in a library with Python, Fortran
2008 and C APIs. Internally, interpolations are handled by
OpenMP-optimized Fortran code that implements Hermite-cubic
tensor-product interpolation in an arbitrary number of
dimensions. Grid data are stored on disk in HDF5-format containers,
and loaded on demand into a memory cache whose size is
user-configurable.

In addition to flux spectra, MSG can interpolate angle-dependent
specific intensities (if the underlying grid contains these data) and
associated quantities such as moments of the radiation field. It can
also convolve spectra with filter/instrument response functions, to
provide corresponding photometric colors. Therefore, it is a
straightforward and complete solution to synthesizing observables
(spectra, colors, etc.) for stellar models; MSG is the ideal seasoning
to add flavor to stellar astrophysics research.

# Figures

Figures can be included like this:
![Caption for example figure.\label{fig:example}](figure.png)
and referenced from text using \autoref{fig:example}.

Figure sizes can be customized by adding an optional second parameter:
![Caption for example figure.](figure.png){ width=20% }

# Acknowledgements

We are grateful to the late Keith Smith for laying the original
foundations for MSG, and likewise acknowledge support from NSF grant
ACI-1663696 and NASA grant 80NSSC20K0515, and .

# References
