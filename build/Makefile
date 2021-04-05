# File     : Makefile
# Purpose  : makefile for build subdir

# Targets

LIB_TARGETS = libforum.${SHARED_LIB_EXT} libmsg.${SHARED_LIB_EXT} libcmsg.${SHARED_LIB_EXT}

ifeq (${TOOLS},yes)
  EXEC_TARGETS := ${EXEC_TARGETS} synspec_to_specint ferre_to_specint \
                  specint_to_photint make_specgrid make_photgrid \
                  make_passband
endif

ifeq (${TESTS},yes)
  EXEC_TARGETS := ${EXEC_TARGETS} test_specgrid test_photgrid
endif

TARGETS = ${LIB_TARGETS} ${EXEC_TARGETS}

# Object files

libforum_OBJS = cinter_m.o const_m.o hdf5io_m.o kinds_m.o memory.o order.o \
                system.o
libforum.dylib_OBJS = ${libforum_OBJS}
libforum.so_OBJS = ${libforum_OBJS}

libmsg_OBJS = libmsg.o axis_m.o ngrid_m.o ncubic_m.o specgrid_m.o specint_m.o \
              specint_factory_m.o dyn_specint_m.o photgrid_m.o photint_m.o \
              passband_m.o cubint_m.o stat_m.o fit_m.o limb_m.o math_m.o
libmsg.dylib_OBJS = ${libmsg_OBJS}
libmsg.so_OBJS = ${libmsg_OBJS}

libcmsg_OBJS = libcmsg.o cinter_m.o
libcmsg.dylib_OBJS = ${libcmsg_OBJS}
libcmsg.so_OBJS = ${libcmsg_OBJS}

synspec_to_specint_OBJS = synspec_to_specint.o kinds_m.o hdf5io_m.o memory_m.o \
                          order_m.o system_m.o

ferre_to_specint_OBJS = ferre_to_specint.o

specint_to_photint_OBJS = specint_to_photint.o

make_specgrid_OBJS = make_specgrid.o

make_photgrid_OBJS = make_photgrid.o

make_passband_OBJS = make_passband.o

test_specgrid_OBJS = test_specgrid.o

test_photgrid_OBJS = test_photgrid.o

# Search subdirs

SUBDIRS = $(wildcard ../src/*)

# Include other makefiles

include Make.inc

# Rules

all : ${TARGETS}

# Additional dependencies

${EXEC_TARGETS} libmsg.${SHARED_LIB_EXT} libcmsg.${SHARED_LIB_EXT} : libforum.${SHARED_LIB_EXT}

${EXEC_TARGETS} libcmsg.${SHARED_LIB_EXT} : libmsg.${SHARED_LIB_EXT}
