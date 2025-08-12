.. _interface-summary:

*****************
Interface Summary
*****************

This chapter briefly summarizes MSG's Python, Fortran and C interfaces.

.. _interface-summary-python:

Python Interface
================

The :ref:`Python interface <python-interface>` is designed around the
:py:class:`pymsg.SpecGrid` and :py:class:`pymsg.PhotGrid` classes,
which support interpolation of spectroscopic and photometric data,
respectively. The table below summarizes the mapping between the
various quantities defined in the :ref:`msg-fundamentals` chapter, and
the methods provided by these classes.

.. list-table:: Python Interpolation Routines
   :widths: 10 60 30
   :header-rows: 1

   * - Symbol
     - Quantity
     - Method
   * - :math:`\intsy`
     - Spectroscopic specific intensity
     - :py:meth:`pymsg.SpecGrid.intensity`
   * - :math:`\emom`
     - Spectroscopic E-moment
     - :py:meth:`pymsg.SpecGrid.E_moment`
   * - :math:`\pmom`
     - Spectroscopic P-moment
     - :py:meth:`pymsg.SpecGrid.P_moment`
   * - :math:`\irrad`
     - Spectroscopic irradiance
     - :py:meth:`pymsg.SpecGrid.irradiance`
   * - :math:`\flux`
     - Spectroscopic flux
     - :py:meth:`pymsg.SpecGrid.flux`
   * - :math:`\mintsy/\fluxz`
     - Photometric specific intensity,
       normalized by zero-point flux
     - :py:meth:`pymsg.PhotGrid.intensity`
   * - :math:`\memom/\fluxz`
     - Photometric E-moment, normalized by zero-point flux
     - :py:meth:`pymsg.PhotGrid.E_moment`
   * - :math:`\mpmom/\fluxz`
     - Photometric P-moment, normalized by zero-point flux
     - :py:meth:`pymsg.PhotGrid.P_moment`
   * - :math:`\mirrad/\fluxz`
     - Photometric irradiance, normalized by zero-point flux
     - :py:meth:`pymsg.PhotGrid.irradiance`
   * - :math:`\mflux/\fluxz`
     - Photometric flux, normalized by zero-point flux
     - :py:meth:`pymsg.PhotGrid.flux`

.. _interface-summary-fortran:

Fortran Interface
=================

The :ref:`Fortran interface <fortran-interface>` is designed around
the :f:type:`~fmsg_m/specgrid_t` and :f:type:`~fmsg_m/photgrid_t`
derived types, which support interpolation of spectroscopic and
photometric data, respectively. The table below summarizes the mapping
between the various quantities defined in the :ref:`msg-fundamentals`
chapter, and the type-bound procedures provided by these types.

.. list-table:: Fortran Interpolation Routines
   :widths: 10 60 30
   :header-rows: 1

   * - Symbol
     - Quantity
     - Procedure
   * - :math:`\intsy`
     - Spectroscopic specific intensity
     - :f:func:`~fmsg_m/specgrid_t%intensity`
   * - :math:`\emom`
     - Spectroscopic E-moment
     - :f:func:`~fmsg_m/specgrid_t%E_moment`
   * - :math:`\pmom`
     - Spectroscopic P-moment
     - :f:func:`~fmsg_m/specgrid_t%P_moment`
   * - :math:`\irrad`
     - Spectroscopic irradiance
     - :f:func:`~fmsg_m/specgrid_t%irradiance`
   * - :math:`\flux`
     - Spectroscopic flux
     - :f:func:`~fmsg_m/specgrid_t%flux`
   * - :math:`\mintsy/\fluxz`
     - Photometric specific intensity,
       normalized by zero-point flux
     - :f:func:`~fmsg_m/photgrid_t%intensity`
   * - :math:`\memom/\fluxz`
     - Photometric E-moment, normalized by zero-point flux
     - :f:func:`~fmsg_m/photgrid_t%E_moment`
   * - :math:`\mpmom/\fluxz`
     - Photometric P-moment, normalized by zero-point flux
     - :f:func:`~fmsg_m/photgrid_t%P_moment`
   * - :math:`\mirrad/\fluxz`
     - Photometric irradiance, normalized by zero-point flux
     - :f:func:`~fmsg_m/photgrid_t%irradiance`
   * - :math:`\mflux/\fluxz`
     - Photometric flux, normalized by zero-point flux
     - :f:func:`~fmsg_m/photgrid_t%flux`

.. _interface-summary-c:

C Interface
===========

The :ref:`C interface <c-interface>` is designed around the
:c:type:`SpecGrid` and :c:type:`PhotGrid` typedefs, which
support interpolation of spectroscopic and photometric data,
respectively. The table below summarizes the mapping between the
various quantities defined in the :ref:`msg-fundamentals` chapter, and
the functions that operate on these types.

.. list-table:: C Interpolation Routines
   :widths: 10 60 30
   :header-rows: 1

   * - Symbol
     - Quantity
     - Function
   * - :math:`\intsy`
     - Spectroscopic specific intensity
     - :c:func:`interp_specgrid_intensity`
   * - :math:`\emom`
     - Spectroscopic E-moment
     - :c:func:`interp_specgrid_E_moment`
   * - :math:`\pmom`
     - Spectroscopic P-moment
     - :c:func:`interp_specgrid_P_moment`
   * - :math:`\irrad`
     - Spectroscopic irradiance
     - :c:func:`interp_specgrid_irradiance`
   * - :math:`\flux`
     - Spectroscopic flux
     - :c:func:`interp_specgrid_flux`
   * - :math:`\mintsy/\fluxz`
     - Photometric specific intensity,
       normalized by zero-point flux
     - :c:func:`interp_photgrid_intensity`
   * - :math:`\memom/\fluxz`
     - Photometric E-moment, normalized by zero-point flux
     - :c:func:`interp_photgrid_E_moment`
   * - :math:`\mpmom/\fluxz`
     - Photometric P-moment, normalized by zero-point flux
     - :c:func:`interp_photgrid_P_moment`
   * - :math:`\mirrad/\fluxz`
     - Photometric irradiance, normalized by zero-point flux
     - :c:func:`interp_photgrid_irradiance`
   * - :math:`\mflux/\fluxz`
     - Photometric flux, normalized by zero-point flux
     - :c:func:`interp_photgrid_flux`
