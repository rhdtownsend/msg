# File     : Makefile
# Purpose  : makefile for build subdir

# Variables

TARGETS = test_math test_order

test_math_SRCS = \
  test_math.fypp \
  test_math_m.fypp \
  linfit_m.fypp \
  order_m.fypp \
  math_m.fypp \
  kinds_m.fypp

test_order_SRCS = \
  test_order.fypp \
  test_order_m.fypp \
  order_m.fypp \
  math_m.fypp \
  kinds_m.fypp

# Targets

all : 

# Include other makefiles

SUBDIRS = ../src:../../forum

include Make.inc

# Additional rules

