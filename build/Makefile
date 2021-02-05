# File     : Makefile
# Purpose  : makefile for build subdir

# Variables

#TARGETS = test_math test_order test_fit
TARGETS = make_radint

make_radint_SRCS = \
  make_radint.f90 \
  radint_m.f90 \
  radint_factory_m.f90 \
  fit_m.f90 \
  kinds_m.f90 \
  const_m.f90 \
  math_m.f90 \
  memory_m.f90 \
  order_m.f90  \
  system_m.f90 \
  hdf5io_m.f90

test_math_SRCS = \
  test_math \
  test_math_m \
  order_m \
  math_m \
  kinds_m

test_order_SRCS = \
  test_order \
  test_order_m \
  order_m \
  math_m \
  kinds_m

test_fit_SRCS = \
  test_fit \
  test_fit_m \
  fit_m \
  kinds_m

# Targets

all : 

# Include other makefiles

SUBDIRS = ../src:../../forum

include Make.inc

# Additional rules

