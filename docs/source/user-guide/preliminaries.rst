*************
Preliminaries
*************

Why use MSG?
============

Synthesizing stellar spectra from first principles is a complicated
endeavor, requiring a detailed understanding of radiative transfer and
atomic physics, together with significant computational
resources. Therefore, in most circumstances its better to use one of
the many pre-calculated grids of spectra published in the
astrophysical literature (see, e.g., :ads_citealp:`lanz:2003`;
:ads_citealp:`lanz:2007`; :ads_citealp:`kirby:2011`;
:ads_citealp:`de-laverny:2012`; :ads_citealp:`husser:2013`;
:ads_citealp:`allende:2018`; :ads_citealp:`chiavassa:2018`;
:ads_citealp:`zsargo:2020`). However, even with these grids a
significant obstacle remains: when photospheric parameters fall
between the grid nodes, some kind of interpolation is necessary in
order to evaluate a spectrum.

MSG is designed to solve this problem. It's not the first software
package that offers stellar spectral interpolation (see, e.g., `FERRE
<http://hebe.as.utexas.edu/ferre/>`__, `Starfish
<https://starfish.readthedocs.io/en/latest/>`__ and `stsynphot
<https://stsynphot.readthedocs.io/en/latest/index.html>`__); however,
with spectral interpolation as its *sole* focus, it offers a
combination of features unmatched by other packages:

* scalability --- MSG handles grids that are much larger
  (on disk) than available computer memory.

* extensibility --- MSG handles grids with an arbitrary
  number of dimensions.

* portability --- MSG is platform-agnostic and provide APIs for the
  programming languages (Python, Fortran, C) most commonly used in
  Astronomy.

* performance --- MSG provides smooth and accurate
  interpolates with minimal computational cost.

* robustness --- MSG gracefully handles missing data
  caused by holes and/or ragged boundaries in the grid.

Together, these features mean that MSG is flexible and powerful while
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

* Townsend Rich, Lopez Aaron, 2022, `Journal of Open-Source Software`, 8(81), 4602, `https://doi.org/10.21105/joss.04 <https://doi.org/10.21105/joss.04602>`__

Be sure to also cite the source of the grid data that you're using
with MSG. For instance, if you're working with one of the `CAP18 grids
<http://user.astro.wisc.edu/~townsend/static.php?ref=msg-grids#CAP18_Grids>`__,
you should cite :ads_citet:`allende:2018`.

Development Team
================

MSG remains under active development by the following team:

* `Rich Townsend <http://www.astro.wisc.edu/~townsend>`__ (University of Wisconsin-Madison); project leader

If you are interested in contributing toward further development of MSG, please see the :ref:`contributing` chapter.

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
