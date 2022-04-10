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

# Link string for FITS library
# (leave blank if not available)
FITS_LDFLAGS = -L/opt/local/lib -lcfitsio

# Targets

LIB_TARGETS = libforum libmsg libfmsg libcmsg
EXEC_TARGETS =
PYM_TARGETS = 

ifeq ($(PYTHON),yes)
  PYM_TARGETS := pymsg_specgrid pymsg_photgrid pymsg_common
endif

ifeq (${TESTS},yes)
  EXEC_TARGETS := ${EXEC_TARGETS} test_specgrid test_photgrid test_spec_photgrid
endif

ifeq (${TOOLS},yes)
  EXEC_TARGETS := ${EXEC_TARGETS} synspec_to_specint ferre_to_specint \
                  specint_to_specint specgrid_to_photgrid make_specgrid \
                  make_bb_photgrid make_passband
  ifneq (${FITS_LDFLAGS},)
    EXEC_TARGETS := ${EXEC_TARGETS} goettingen_to_specint
  endif
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

libmsg_OBJS = msg_m.o axis_m.o ngrid_m.o ncubic_m.o \
              range_m.o range_sm.o comp_range_m.o lin_range_m.o log_range_m.o tab_range_m.o \
              specgrid_m.o speccache_m.o specsource_m.o hdf5_specsource_m.o specint_m.o specint_sm.o limb_specint_m.o proxy_specint_m.o \
              photgrid_m.o photcache_m.o photsource_m.o hdf5_photsource_m.o spec_photsource_m.o mem_photsource_m.o photint_m.o photint_sm.o limb_photint_m.o \
              passband_m.o cubint_m.o stat_m.o fit_m.o limb_m.o math_m.o
libmsg_LIBS = libforum
libmsg_DEPS = forum_m

libfmsg_OBJS = fmsg_m.o
libfmsg_LIBS = libforum libmsg
libfmsg_DEPS = forum_m msg_m

libcmsg_OBJS = cmsg_m.o cmsg_spec_m.o cmsg_phot_m.o cmsg_utils_m.o
libcmsg_LIBS = libforum libmsg
libcmsg_DEPS = forum_m msg_m

pymsg_specgrid_OBJS = pymsg_specgrid.o
pymsg_specgrid_LIBS = libforum libmsg libcmsg

pymsg_photgrid_OBJS = pymsg_photgrid.o
pymsg_photgrid_LIBS = libforum libmsg libcmsg

pymsg_common_OBJS = pymsg_common.o
pymsg_common_LIBS = libforum libmsg libcmsg

synspec_to_specint_OBJS = synspec_to_specint.o
synspec_to_specint_LIBS = libforum libmsg
synspec_to_specint_DEPS = forum_m msg_m

ferre_to_specint_OBJS = ferre_to_specint.o
ferre_to_specint_LIBS = libforum libmsg
ferre_to_specint_DEPS = forum_m msg_m

goettingen_to_specint_OBJS = goettingen_to_specint.o
goettingen_to_specint_LIBS = libforum libmsg
goettingen_to_specint_DEPS = forum_m msg_m

parse_wavelen_OBJS = parse_wavelen.o
parse_wavelen_LIBS = libforum libmsg
parse_wavelen_DEPS = forum_m msg_m

specint_to_specint_OBJS = specint_to_specint.o
specint_to_specint_LIBS = libforum libmsg
specint_to_specint_DEPS = forum_m msg_m

specgrid_to_photgrid_OBJS = specgrid_to_photgrid.o
specgrid_to_photgrid_LIBS = libforum libmsg
specgrid_to_photgrid_DEPS = forum_m msg_m

make_specgrid_OBJS = make_specgrid.o
make_specgrid_LIBS = libforum libmsg
make_specgrid_DEPS = forum_m msg_m

make_photgrid_OBJS = make_photgrid.o
make_photgrid_LIBS = libforum libmsg
make_photgrid_DEPS = forum_m msg_m

make_bb_photgrid_OBJS = make_bb_photgrid.o
make_bb_photgrid_LIBS = libforum libmsg
make_bb_photgrid_DEPS = forum_m msg_m

make_passband_OBJS = make_passband.o
make_passband_LIBS = libforum libmsg
make_passband_DEPS = forum_m msg_m

test_specgrid_OBJS = test_specgrid.o
test_specgrid_LIBS = libforum libmsg libfmsg
test_specgrid_DEPS = forum_m fmsg_m

test_photgrid_OBJS = test_photgrid.o
test_photgrid_LIBS = libforum libmsg libfmsg
test_photgrid_DEPS = forum_m fmsg_m

test_spec_photgrid_OBJS = test_spec_photgrid.o
test_spec_photgrid_LIBS = libforum libmsg libfmsg
test_spec_photgrid_DEPS = forum_m fmsg_m

# Search subdirs

GITMODS = forum
SUBDIRS = $(filter-out ${GITMODS},$(wildcard ../src/*)) $(wildcard $(patsubst %,../src/%/src,${GITMODS}))

# Include other makefiles

include Make.inc

# Additional dependencies

pymsg_specgrid.c : pymsg_common.pyx
pymsg_photgrid.c : pymsg_common.pyx

pymsg_specgrid.o : cmsg.h
pymsg_photgrid.o : cmsg.h





