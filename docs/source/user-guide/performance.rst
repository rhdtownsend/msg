.. _performance:

 .. f:currentmodule:: fmsg_m

******************
Performance Tuning
******************

This chapter describes various steps that can be taken to tune (and
thereby hopefully improve) MSG's computational performance.

Data Caching
============

The first and most obvious step to improving performance is to make
sure that MSG's data caching is appropriately configured. See the
:ref:`data-caching` chapter for full details.

Photgrid Files
==============

As mentioned in the :ref:`data-files-importing` section, MSG supports
loading a :f-schema:`specgrid` file and then convolving with a
passband on-the-fly. There is a performance penalty to this approach:
when photmetric data are required and are not already in the cache,
the corresponding spectroscopic data must be read from the
:f-schema:`specgrid` file and then convolved. To avoid this penalty,
consider instead creating a :f-schema:`photgrid` file using the
:program:`specgrid_to_photgrid` tool (described in the
:ref:`grid-tools` chapter), and working with this file directly.

Linear Interpolation
====================

By default MSG uses cubic :ref:`tensor product interpolation
<tensor-product-interpolation>`, which ensures that both interpolated
functions *and* their first derivatives vary smoothly with respect to
the photospheric parameters :math:`\vx` (that is, the functions are
:math:`C^{1}` continuous). If smoothness in the first derivatives is
not required, then consider using linear interpolation instead.

This can be achieved by setting the optional `order` argument to
`1`. For instance, a call to the function
:py:func:`pymsg.PhotGrid.flux` would look like this:

.. code:: python

   F = photgrid.flux(x, order=1)

The performance boost from replacing cubic interpolation with linear
can be significant --- of order :math:`4^N`, where :math:`N` is the
number of photospheric parameters.

Interface Language
==================

The :ref:`Python interface <python-interface>` to MSG is by far the
most user-friendly, but it has the disadvantage that Python is an
interpreted language. While most of the intensive calculations
performed by MSG are handled by compiled code, there is inevitably an
overhead to accessing this code from Python. If good performance is
critical, then consider switching the :ref:`Fortran interface
<fortran-interface>` or the :ref:`C interface <c-interface>`.

Parallelization
===============

In situations where multiple, independent calls to MSG routines are
required, cosider using `OpenMP <https://www.openmp.org/>`__
directives to run the calculations in parallel on multiple processor
cores\ [#thread-safe]_. First, ensure that MSG has been built with the
:envvar:`OMP` environment variable set to ``yes`` (see the
:ref:`installation` chapter for further details). Then, call MSG
within a loop with an appropriate OpenMP directive. In Fortran, the
code might look like this:

.. code:: fortran

   ! Input: photospheric parameters stored in x_vec(:,:)
   ! Output: photometric flux stored in F(:)

   !$OMP PARALLEL DO
   do i = 1, SIZE(x_vec, 2)
      call photgrid%interp_flux(x_vec(:,i), F(i))
   end do
   !$OMP END PARALLEL DO

A similar approach can be used in C.

Unfortunately Python doesn't support this kind of parallelization, due
to its `global interpreter lock
<https://wiki.python.org/moin/GlobalInterpreterLock>`__. However, it
still benefits from OpenMP parallelization *within* MSG. Specifically,
the routines for evaluating the spectroscopic irradiance
:math:`\irrad` and photometric irradiance :math:`\mirrad` (see the
:ref:`routine-mapping` table) add the contributions from each visible
photospheric element in parallel.

.. rubric:: footnote

.. [#thread-safe] All MSG interpolation routines are thread-safe under
                  OpenMP.
