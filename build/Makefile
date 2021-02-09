# File     : Makefile
# Purpose  : makefile for build subdir

# Variables

TARGETS = test_math test_order test_fit make_specint

make_specint_SRCS = \
  make_specint.f90 \
  specint_m.f90 \
  specint_factory_m.f90 \
  fit_m.f90 \
  kinds_m.f90 \
  const_m.f90 \
  limb_m.f90 \
  math_m.f90 \
  memory_m.f90 \
  order_m.f90  \
  system_m.f90 \
  hdf5io_m.f90

test_math_SRCS = \
  test_math.f90 \
  test_math_m.f90 \
  order_m.f90 \
  math_m.f90 \
  kinds_m.f90

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

# Targets

all : 

# Include other makefiles

SUBDIRS = ../src:../../forum

# Additional rules

include Make.inc

