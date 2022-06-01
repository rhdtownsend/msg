---
title: 'MSG: A software package for interpolating stellar spectra in pre-calculated grids'
tags:
  - Python
  - Fortran
  - C
  - astronomy
  - spectra
  - stars
  - grids
  - interpolation
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
atmosphere, this process is computationally expensive.  Therefore, it
is often far more efficient to pre-calculate spectra over a grid of
atmospheric parameters, and then interpolate within this grid.  `MSG`
(short for Multidimensional Spectral Grids) is a software package that
implements this interpolation capability.

# Statement of Need

There are a wide variety of stellar spectral grids published in the
astronomical literature --- examples include @Lanz:2003, @Lanz:2007,
@Kirby:2011, @de-Laverny:2012, @Husser:2013, @Allende-Prieto:2018,
@Chiavassa:2018 and @Zsargo:2020. However, the ecosystem of software
packages that offer users the ability to interpolate in these grids is
much more limited. iSPEC [@Blanco-Cuaresma:2014] and FERRE
[@Allende-Prieto:2015] stand out in this category, but their principal
focus is spectral analysis (determining stellar atmosphere parameters
by fitting observed spectra) rather than interpolation; and, as
monolithic packages they are not well suited to modular incorporation
within other projects. These considerations motivate us to develop
MSG.

# Capabilities

MSG is implemented as a software library with Python, Fortran 2008 and
C bindings. These APIs are underpinned by OpenMP-parallelized Fortran
code that performs energy-conservative interpolation in wavelength
$\lambda$, parametric interpolation in direction cosine $\mu$ using
limb-darkening laws, and $C^{1}$-continuous cubic tensor-product
interpolation in an arbitrary number of atmosphere parameters
(effective temperature $T_{\mathrm{eff}}$, surface gravity $g$,
metallicity [Fe/H], etc.). Although the topology of grid points must
remain Cartesian, their distribution along each separate dimension
need not be uniform. Attempts to interpolate in regions with missing
data (e.g., ragged grid boundaries and/or holes) are handled
gracefully via exceptions (Python) or returned status codes (Fortran
and C).

To minimize disk space requirements, MSG grids are stored in HDF5
container files with a flexible and extensible schema. Tools are
provided that can create these files from existing grids in other
formats. Rather than reading an entire grid into memory during program
start-up (which is slow and may not even be possible, given that some
grids can be hundreds of gigabytes in size), MSG loads data into a
cache only when needed; and once the cache occupancy reaches a
user-specified limit, data are evicted using a least-recently-used
algorithm.

In addition to intensity and flux spectra, MSG can evaluate associated
quantities such as moments of the radiation field. It can also
convolve spectra on-the-fly with filter/instrument response functions,
to provide corresponding photometric colors. Therefore, it is a
straightforward and complete solution to synthesizing observables
(spectra, colors, etc.) for stellar models, and serves as an ideal
seasoning to add flavor to stellar astrophysics research.

# Acknowledgments

We are grateful to the late Keith Smith for laying the original
foundations for MSG, and likewise acknowledge support from NSF grant
ACI-1663696 and NASA grant 80NSSC20K0515.

# References
