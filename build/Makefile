# File     : Makefile
# Purpose  : makefile for build subdir

# Variables

#TARGETS = test_math test_order test_fit
TARGETS = make_radint

make_radint_SRCS = \
  make_radint.fypp \
  radint_m.fypp \
  radint_factory_m.fypp \
  fit_m.fypp \
  kinds_m.fypp \
  const_m.fypp \
  math_m.fypp \
  memory_m.fypp \
  order_m.fypp \
  system_m.fypp \
  hdf5io_m.fypp \
  hdf5io_read_sm.fypp \
  hdf5io_alloc_read_sm.fypp \
  hdf5io_write_sm.fypp

test_math_SRCS = \
  test_math.fypp \
  test_math_m.fypp \
  order_m.fypp \
  math_m.fypp \
  kinds_m.fypp

test_order_SRCS = \
  test_order.fypp \
  test_order_m.fypp \
  order_m.fypp \
  math_m.fypp \
  kinds_m.fypp

test_fit_SRCS = \
  test_fit.fypp \
  test_fit_m.fypp \
  fit_m.fypp \
  kinds_m.fypp

# Targets

all : 

# Include other makefiles

SUBDIRS = ../src:../../forum

include Make.inc

# Additional rules

