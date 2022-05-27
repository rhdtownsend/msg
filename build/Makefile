# File     : Makefile
# Purpose  : makefile for build subdir

# Default settings

# Build Python interface
PYTHON ?= yes

# Build test programs
TESTS ?= no

# Build tool executables
TOOLS ?= no

# Enable debugging (with a performance penalty)
DEBUG ?= no

# Enable OpenMP parallelization
OMP ?= yes

# Enable FPE checks
FPE ?= yes

# Link string for FITS library
# (leave undefined if not available)
#FITS_LDFLAGS = -L/opt/local/lib -lcfitsio

# Targets

LIB_TARGETS = libforum libmsg libfmsg libcmsg
EXEC_TARGETS =
PYC_TARGETS = 

ifeq ($(PYTHON),yes)
  PYC_TARGETS := pycmsg
endif

ifeq (${TESTS},yes)
  UTEST_TARGETS := utest_fit utest_math utest_cubint utest_ncubic utest_specgrid utest_photgrid
  TIME_TARGETS := time_specgrid
  EXEC_TARGETS := ${EXEC_TARGETS} ${UTEST_TARGETS} ${TIME_TARGETS}
endif

ifeq (${TOOLS},yes)
  EXEC_TARGETS := ${EXEC_TARGETS} synspec_to_specint ferre_to_specint \
                  specint_to_specint specgrid_to_photgrid specint_to_specgrid \
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

libmsg_OBJS = msg_m.o axis_m.o vgrid_m.o ncubic_m.o \
              range_m.o range_sm.o comp_range_m.o lin_range_m.o log_range_m.o tab_range_m.o \
              specgrid_m.o speccache_m.o specsource_m.o hdf5_specsource_m.o specint_m.o specint_sm.o limb_specint_m.o proxy_specint_m.o \
              photgrid_m.o photcache_m.o photsource_m.o hdf5_photsource_m.o spec_photsource_m.o mem_photsource_m.o photint_m.o photint_sm.o limb_photint_m.o \
              passband_m.o cubint_m.o stat_m.o file_m.o fit_m.o limb_m.o math_m.o
libmsg_LIBS = libforum
libmsg_DEPS = forum_m

libfmsg_OBJS = fmsg_m.o
libfmsg_LIBS = libforum libmsg
libfmsg_DEPS = forum_m msg_m

libcmsg_OBJS = cmsg_m.o cmsg_spec_m.o cmsg_phot_m.o cmsg_utils_m.o
libcmsg_LIBS = libforum libmsg
libcmsg_DEPS = forum_m msg_m

pycmsg_OBJS = pycmsg.o
pycmsg_LIBS = libforum libmsg libcmsg

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

specint_to_specgrid_OBJS = specint_to_specgrid.o
specint_to_specgrid_LIBS = libforum libmsg
specint_to_specgrid_DEPS = forum_m msg_m

make_photgrid_OBJS = make_photgrid.o
make_photgrid_LIBS = libforum libmsg
make_photgrid_DEPS = forum_m msg_m

make_bb_photgrid_OBJS = make_bb_photgrid.o
make_bb_photgrid_LIBS = libforum libmsg
make_bb_photgrid_DEPS = forum_m msg_m

make_passband_OBJS = make_passband.o
make_passband_LIBS = libforum libmsg
make_passband_DEPS = forum_m msg_m

utest_fit_OBJS = utest_fit.o utest_fit_m.o
utest_fit_LIBS = libforum libmsg
utest_fit_DEPS = forum_m fit_m

utest_math_OBJS = utest_math.o utest_math_m.o
utest_math_LIBS = libforum libmsg
utest_math_DEPS = forum_m math_m

utest_cubint_OBJS = utest_cubint.o utest_cubint_m.o
utest_cubint_LIBS = libforum libmsg
utest_cubint_DEPS = forum_m cubint_m

utest_ncubic_OBJS = utest_ncubic.o utest_ncubic_m.o
utest_ncubic_LIBS = libforum libmsg
utest_ncubic_DEPS = forum_m ncubic_m

utest_specgrid_OBJS = utest_specgrid.o utest_specgrid_m.o
utest_specgrid_LIBS = libforum libmsg libfmsg
utest_specgrid_DEPS = forum_m fmsg_m

utest_photgrid_OBJS = utest_photgrid.o utest_photgrid_m.o
utest_photgrid_LIBS = libforum libmsg libfmsg
utest_photgrid_DEPS = forum_m fmsg_m

test_specgrid_OBJS = test_specgrid.o
test_specgrid_LIBS = libforum libmsg libfmsg
test_specgrid_DEPS = forum_m fmsg_m

time_specgrid_OBJS = time_specgrid.o
time_specgrid_LIBS = libforum libmsg libfmsg
time_specgrid_DEPS = forum_m fmsg_m

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

pycmsg.o : cmsg.h
