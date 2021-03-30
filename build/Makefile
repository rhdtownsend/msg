# File     : Makefile
# Purpose  : makefile for build subdir

# Variables

#TARGETS = test_math test_interp test_order test_fit
#TARGETS = synspec_to_specint specint_to_photint make_passband make_specgrid test_specgrid make_photgrid test_photgrid libmsg.${SHARED_LIB_EXT} libcmsg.${SHARED_LIB_EXT}
#TARGETS = test_ncubic
TARGETS = synspec_to_specint make_specgrid test_specgrid make_photgrid specint_to_photint libcmsg.${SHARED_LIB_EXT}

test_ncubic_SRCS = \
  test_ncubic.f90 \
  test_ncubic_m.f90 \
  ncubic_m.f90 \
  stat_m.f90 \
  order_m.f90 \
  kinds_m.f90

synspec_to_specint_SRCS = \
  synspec_to_specint.f90 \
  specint_m.f90 \
  specint_factory_m.f90 \
  photint_m.f90 \
  passband_m.f90 \
  stat_m.f90 \
  cubint_m.f90 \
  fit_m.f90 \
  kinds_m.f90 \
  const_m.f90 \
  limb_m.f90 \
  math_m.f90 \
  memory_m.f90 \
  order_m.f90 \
  system_m.f90 \
  hdf5io_m.f90 \
  cinter_m.f90

specint_to_photint_SRCS = \
  specint_to_photint.f90 \
  specint_m.f90 \
  photint_m.f90 \
  passband_m.f90 \
  cubint_m.f90 \
  fit_m.f90 \
  kinds_m.f90 \
  const_m.f90 \
  limb_m.f90 \
  math_m.f90 \
  memory_m.f90 \
  order_m.f90 \
  system_m.f90 \
  hdf5io_m.f90 \
  cinter_m.f90

make_passband_SRCS = \
  make_passband.f90 \
  passband_m.f90 \
  cubint_m.f90 \
  kinds_m.f90 \
  const_m.f90 \
  order_m.f90 \
  system_m.f90 \
  hdf5io_m.f90 \
  cinter_m.f90

make_specgrid_SRCS = \
  make_specgrid.f90 \
  axis_m.f90 \
  ngrid_m.f90 \
  ncubic_m.f90 \
  specgrid_m.f90 \
  specint_m.f90 \
  dyn_specint_m.f90 \
  photint_m.f90 \
  passband_m.f90 \
  cubint_m.f90 \
  stat_m.f90 \
  fit_m.f90 \
  kinds_m.f90 \
  const_m.f90 \
  limb_m.f90 \
  math_m.f90 \
  order_m.f90 \
  system_m.f90 \
  hdf5io_m.f90 \
  cinter_m.f90

test_specgrid_SRCS = \
  test_specgrid.f90 \
  axis_m.f90 \
  ngrid_m.f90 \
  ncubic_m.f90 \
  specgrid_m.f90 \
  specint_m.f90 \
  dyn_specint_m.f90 \
  photint_m.f90 \
  passband_m.f90 \
  cubint_m.f90 \
  fit_m.f90 \
  kinds_m.f90 \
  const_m.f90 \
  limb_m.f90 \
  math_m.f90 \
  cinter_m.f90 \
  order_m.f90 \
  system_m.f90 \
  hdf5io_m.f90 \
  cinter_m.f90 \
  stat_m.f90

make_photgrid_SRCS = \
  make_photgrid.f90 \
  axis_m.f90 \
  ngrid_m.f90 \
  ncubic_m.f90 \
  photgrid_m.f90 \
  photint_m.f90 \
  stat_m.f90 \
  fit_m.f90 \
  kinds_m.f90 \
  const_m.f90 \
  limb_m.f90 \
  math_m.f90 \
  order_m.f90 \
  system_m.f90 \
  hdf5io_m.f90 \
  cinter_m.f90

test_photgrid_SRCS = \
  test_photgrid.f90 \
  grid_m.f90 \
  grid_interp_m.f90 \
  photgrid_m.f90 \
  photint_m.f90 \
  fit_m.f90 \
  kinds_m.f90 \
  const_m.f90 \
  limb_m.f90 \
  math_m.f90 \
  cinter_m.f90 \
  order_m.f90 \
  system_m.f90 \
  hdf5io_m.f90 \
  cinter_m.f90 \
  stat_m.f90

libmsg.so_SRCS = \
  libmsg.f90 \
  grid_m.f90 \
  grid_interp_m.f90 \
  specint_m.f90 \
  dyn_specint_m.f90 \
  specgrid_m.f90 \
  photint_m.f90 \
  passband_m.f90 \
  cubint_m.f90 \
  photint_m.f90 \
  photgrid_m.f90 \
  fit_m.f90 \
  kinds_m.f90 \
  const_m.f90 \
  limb_m.f90 \
  math_m.f90 \
  cinter_m.f90 \
  order_m.f90 \
  system_m.f90 \
  hdf5io_m.f90 \
  cinter_m.f90 \
  stat_m.f90

libmsg.dylib_SRCS = ${libmsg.so_SRCS}

libcmsg.so_SRCS = \
  libcmsg.f90 \
  axis_m.f90 \
  ngrid_m.f90 \
  ncubic_m.f90 \
  specint_m.f90 \
  dyn_specint_m.f90 \
  specgrid_m.f90 \
  photint_m.f90 \
  passband_m.f90 \
  cubint_m.f90 \
  photint_m.f90 \
  photgrid_m.f90 \
  fit_m.f90 \
  kinds_m.f90 \
  const_m.f90 \
  limb_m.f90 \
  math_m.f90 \
  cinter_m.f90 \
  order_m.f90 \
  system_m.f90 \
  hdf5io_m.f90 \
  cinter_m.f90 \
  stat_m.f90

libcmsg.dylib_SRCS = ${libcmsg.so_SRCS}

test_hdf5io_SRCS = \
  test_hdf5io.f90 \
  kinds_m.f90 \
  hdf5io_m.f90 \
  cinter_m.f90 \
  system_m.f90

test_math_SRCS = \
  test_math.f90 \
  test_math_m.f90 \
  order_m.f90 \
  math_m.f90 \
  kinds_m.f90

test_grid_interp_SRCS = \
  test_grid_interp.f90 \
  test_grid_interp_m.f90 \
  grid_interp_m.f90 \
  order_m.f90 \
  kinds_m.f90 \
  stat_m.f90

test_order_SRCS = \
  test_order.f90 \
  test_order_m.f90 \
  order_m.f90 \
  math_m.f90 \
  kinds_m.f90

test_fit_SRCS = \
  test_fit.f90 \
  test_fit_m.f90 \
  fit_m.f90 \
  kinds_m.f90

test_cubint_SRCS = \
  test_cubint.f90 \
  test_cubint_m.f90 \
  hdf5io_m.f90 \
  cinter_m.f90 \
  cubint_m.f90 \
  order_m.f90 \
  kinds_m.f90

# Targets

all : 

# Include other makefiles

SUBDIRS = ../src:../../forum

# Additional rules

include Make.inc

