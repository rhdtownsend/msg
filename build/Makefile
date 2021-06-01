# File     : Makefile
# Purpose  : makefile for build subdir

# Default settings

# Build Python interface
PYTHON ?= yes

# Build test programs
TESTS ?= yes

# Build tool executables
TOOLS ?= no

# Enable debugging (with a performance penalty)
DEBUG ?= no

# Enable OpenMP parallelization
OMP ?= yes

# Enable FPE checks
FPE ?= yes

# Targets

LIB_TARGETS = libforum libmsg libcmsg
EXEC_TARGETS =
PYM_TARGETS = 

ifeq ($(PYTHON),yes)
  PYM_TARGETS := pymsg
endif

ifeq (${TESTS},yes)
  EXEC_TARGETS := ${EXEC_TARGETS} test_specgrid test_photgrid
endif

ifeq (${TOOLS},yes)
  EXEC_TARGETS := ${EXEC_TARGETS} synspec_to_specint ferre_to_specint \
             specint_to_specint specint_to_photint specgrid_to_photgrid \
             make_specgrid make_photgrid make_passband
endif

# Object lists & related variables
#
# libxxx_OBJS = object files required to compile libxxx
# lbbxxx_DEPS = dependency that must be added to .libxxx.d file  
#
# prog_OBJS = object files required to compile prog
# prog_LIBS = library files required to link prog
# prog_DEPS = dependencies that must be added to .prog.d file

libforum_OBJS = forum_m.o cinter_m.o const_m.o hdf5io_m.o kinds_m.o memory_m.o \
                order_m.o system_m.o

libmsg_OBJS = msg_m.o axis_m.o ngrid_m.o ncubic_m.o specgrid_m.o specint_m.o \
              specint_factory_m.o dyn_specint_m.o photgrid_m.o photint_m.o \
              passband_m.o cubint_m.o stat_m.o fit_m.o limb_m.o math_m.o
libmsg_LIBS = libforum
libmsg_DEPS = forum_m

libcmsg_OBJS = cmsg_m.o
libcmsg_LIBS = libforum libmsg
libcmsg_DEPS = forum_m msg_m

pymsg_OBJS = pymsg.o
pymsg_LIBS = libforum libmsg libcmsg

synspec_to_specint_OBJS = synspec_to_specint.o
synspec_to_specint_LIBS = libforum libmsg
synspec_to_specint_DEPS = forum_m msg_m

ferre_to_specint_OBJS = ferre_to_specint.o
ferre_to_specint_LIBS = libforum libmsg
ferre_to_specint_DEPS = forum_m msg_m

specint_to_specint_OBJS = specint_to_specint.o
specint_to_specint_LIBS = libforum libmsg
specint_to_specint_DEPS = forum_m msg_m

specint_to_photint_OBJS = specint_to_photint.o
specint_to_photint_LIBS = libforum libmsg
specint_to_photint_DEPS = forum_m msg_m

specgrid_to_photgrid_OBJS = specgrid_to_photgrid.o
specgrid_to_photgrid_LIBS = libforum libmsg
specgrid_to_photgrid_DEPS = forum_m msg_m

make_specgrid_OBJS = make_specgrid.o
make_specgrid_LIBS = libforum libmsg
make_specgrid_DEPS = forum_m msg_m

make_photgrid_OBJS = make_photgrid.o
make_photgrid_LIBS = libforum libmsg
make_photgrid_DEPS = forum_m msg_m

make_passband_OBJS = make_passband.o
make_passband_LIBS = libforum libmsg
make_passband_DEPS = forum_m msg_m

test_specgrid_OBJS = test_specgrid.o
test_specgrid_LIBS = libforum libmsg
test_specgrid_DEPS = forum_m msg_m

test_photgrid_OBJS = test_photgrid.o
test_photgrid_LIBS = libforum libmsg
test_photgrid_DEPS = forum_m msg_m

# Search subdirs

GITMODS = forum
SUBDIRS = $(filter-out ${GITMODS},$(wildcard ../src/*)) $(wildcard $(patsubst %,../src/%/src,${GITMODS}))

# Include other makefiles

include Make.inc

# Additional dependencies

pymsg.o : cmsg.h

