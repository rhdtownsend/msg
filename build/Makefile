# File     : Makefile
# Purpose  : makefile for build subdir

# Targets

TARGETS = libforum libmsg libcmsg

ifeq (${TOOLS},yes)
  TARGETS := ${TARGETS} synspec_to_specint ferre_to_specint \
             specint_to_photint make_specgrid make_photgrid \
             make_passband
endif

ifeq (${TESTS},yes)
  TARGETS := ${TARGETS} test_specgrid test_photgrid
endif

# Object files

libforum_OBJS = libforum_m.o cinter_m.o const_m.o hdf5io_m.o kinds_m.o memory_m.o \
                order_m.o system_m.o

libmsg_OBJS = libmsg_m.o axis_m.o ngrid_m.o ncubic_m.o specgrid_m.o specint_m.o \
              specint_factory_m.o dyn_specint_m.o photgrid_m.o photint_m.o \
              passband_m.o cubint_m.o stat_m.o fit_m.o limb_m.o math_m.o
libmsg_LIBS = libforum

libcmsg_OBJS = libcmsg_m.o
libcmsg_LIBS = libforum libmsg

synspec_to_specint_OBJS = synspec_to_specint.o
synspec_to_specint_LIBS = libforum libmsg

ferre_to_specint_OBJS = ferre_to_specint.o
ferre_to_specint_LIBS = libforum libmsg

specint_to_photint_OBJS = specint_to_photint.o
specint_to_photint_LIBS = libforum libmsg

make_specgrid_OBJS = make_specgrid.o
make_specgrid_LIBS = libforum libmsg

make_photgrid_OBJS = make_photgrid.o
make_photgrid_LIBS = libforum libmsg

make_passband_OBJS = make_passband.o
make_passband_LIBS = libforum libmsg

test_specgrid_OBJS = test_specgrid.o
test_specgrid_LIBS = libforum libmsg

test_photgrid_OBJS = test_photgrid.o
test_photgrid_LIBS = libforum libmsg

# Search subdirs

SUBDIRS = $(wildcard ../src/*)

# Include other makefiles

include Make.inc
