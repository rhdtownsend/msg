*************
Preliminaries
*************

What is MSG?
============

Multidimensional Spectral Grids (MSG) is an open-source software
library that synthesizes astrophysical spectra and photometric colors
via interpolation in pre-calculated grids.  Given a set of stellar
atmospheric parameters (e.g., effective temperature, gravity and
metallicity), MSG can evaluate the specific intensity of the emergent
radiation field as a function of wavelength and angle. It can also
convolve these data with appropriate filters and response functions,
to evaluate colors in a wide variety of photometric systems.

MSG is free software: you can redistribute it and/or modify it under
the terms of the `GNU General Public License
<http://www.gnu.org/licenses/gpl-3.0.html>`__ as published by the
`Free Software Foundation <https://www.fsf.org/>`__, version 3.

Why use MSG?
============

Synthesizing stellar spectra from first principles is a complicated
endeavor, requiring a detailed understanding of radiative transfer and
atomic physics, together with significant computational
resources. Therefore, in most circumastances its better to use one of
the many pre-calculated grids of spectra published in the
astrophysical literature (see, e.g., :ads_citealp:`castelli:2003`;
:ads_citealp:`lanz:2003`; :ads_citealp:`husser:2013`;
:ads_citealp:`allende:2018`). However, even with these grids a
significant obstacle remains: when atmospheric parameters fall between
the grid nodes, some kind of interpolation is necessary in order to
evaluate a spectrum.

MSG is desgined to solve this problem. It's not the first software
package devoted to stellar spectral interpolation (see, e.g.,
:ads_citealt:`bertrandelis:2022`); however, it is indtended as
general-purpose library that's not tied to any specific grid, and
therefore its design has been guided by the following key criteria:

* scalability --- the library must handle grids that are much larger
  (on disk) than available computer memory.

* extensibility --- the library muast handle grids with an arbitrary
  number of dimensions.

* portability --- the library must be platform-agnostic and provide
  APIs for the programming languages commonly used in Astronomy
  (Fortran, C, Python).

* performance --- the library must provide smooth and accurate
  interpolates with minimal computational cost.

* robustness --- the library must gracefully handle missing data
  caused by holes and/or ragged boundaries in the grid.

Together, these criteria mean that MSG is flexible and powerful while
remaining straightforward to use: it's the perfect condiment to add
:wiki:`flavor <Monosodium_glutamate>` to your science!.

Obtaining MSG
=============

The source code for MSG is hosted in the :git:`rhdtownsend/msg` git
repository on :git:`GitHub <>`. Instructions for downloading and
installing the software can be found in the :ref:`Quick Start
<quick-start>` chapter.

.. _citing-msg:

Citing MSG
==========

If you use MSG in your research, please cite the following papers:

* Townsend R. H. D., Lopez A., 2022, `Journal of Open-Source Software`, in preparation

Be sure to also cite the source of the grid data that you're using with MSG. For instance, if you're
working with one of the :ref:`CAP18 grids <grid-files-CAP18>`, you
should cite :ads_citet:`allende:2018`.

Development Team
================

MSG remains under active development by the following team:

* `Rich Townsend <http://www.astro.wisc.edu/~townsend>`__ (University of Wisconsin-Madison); project leader
* `Aaron Lopez <http://github.com/aaronesque>`__ (University of Wisconsin-Madison)  

Related Links
=============

* The `MESA Software Development Kit (SDK) <mesa-sdk_>`__, which
  provides the compilers and supporting libraries needed to build
  MSG.

Acknowledgments
================

MSG has been developed with financial support from the following grants:

* NSF awards ACI-1663696 and AST-1716436;
* NASA award 80NSSC20K0515.
