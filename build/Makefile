# File     : Makefile
# Purpose  : makefile for build subdir

# Default rule in case make is invoked in current dir

all:
	make -C ..

# Targets

LIB_TARGETS = libmsg libfmsg libcmsg

INC_FILES = msg_m.mod fmsg_m.mod cmsg_m.mod

ifeq ($(PYTHON),yes)
  PYC_TARGETS := pycmsg
endif

ifeq ($(TESTS),yes)
  UTEST_TARGETS := utest_file utest_fit utest_math utest_cubint utest_ninterp utest_axis utest_vgrid utest_specgrid utest_photgrid
  STRESS_TARGETS := stress_specgrid stress_photgrid
  TIME_TARGETS := time_vgrid time_specgrid
  BIN_TARGETS += $(UTEST_TARGETS) $(STRESS_TARGETS) $(TIME_TARGETS)
endif

ifeq ($(TOOLS),yes)
  BIN_TARGETS += ascii_to_specint synspec_to_specint ferre_to_specint	\
                 c3k_to_specint specint_to_specint			\
                 specgrid_to_photgrid specint_to_specgrid		\
                 make_bb_photgrid make_passband make_photon_passband	\
                 inspect_grid
  ifneq ($(FITS_LDFLAGS),)
    BIN_TARGETS += goettingen_to_specint coelho_to_specint
  endif
endif

# Source file lists & related variables
#
# xxx_SRCS = source files required to compile xxx
# xxx_USES = source files providing modules USE'd by xxx
# xxx_LIBS = library files required to link xxx

axis_SRCS = axis_m.fypp axis_construct_sm.fypp axis_attribs_sm.fypp \
            axis_locate_sm.fypp axis_io_sm.fypp

ninterp_SRCS = ninterp_m.fypp ninterp_linear_sm.fypp ninterp_cubic_sm.fypp \
               basis_m.fypp

vgrid_SRCS = vgrid_m.fypp vgrid_construct_sm.fypp vgrid_index_sm.fypp \
             vgrid_attribs_sm.fypp vgrid_interp_sm.fypp vgrid_traverse_sm.fypp \
             vgrid_io_sm.fypp

photcache_SRCS = photcache_m.fypp photcache_construct_sm.fypp photcache_attribs_sm.fypp \
                 photcache_access_sm.fypp

photgrid_SRCS = photgrid_m.fypp photgrid_construct_sm.fypp photgrid_attribs_sm.fypp \
                photgrid_interp_sm.fypp photgrid_io_sm.fypp

photint_SRCS = photint_m.fypp photint_sm.fypp \
               limb_photint_m.fypp limb_photint_construct_sm.fypp limb_photint_attribs_sm.fypp \
               limb_photint_interp_sm.fypp limb_photint_io_sm.fypp

photsource_SRCS = photsource_m.fypp \
                  hdf5_photsource_m.fypp hdf5_photsource_construct_sm.fypp \
                  hdf5_photsource_attribs_sm.fypp hdf5_photsource_access_sm.fypp \
                  mem_photsource_m.fypp mem_photsource_construct_sm.fypp \
                  mem_photsource_attribs_sm.fypp mem_photsource_access_sm.fypp \
                  spec_photsource_m.fypp spec_photsource_construct_sm.fypp \
                  spec_photsource_attribs_sm.fypp spec_photsource_access_sm.fypp

speccache_SRCS = speccache_m.fypp speccache_construct_sm.fypp speccache_attribs_sm.fypp \
                  speccache_access_sm.fypp

specgrid_SRCS = specgrid_m.fypp specgrid_construct_sm.fypp specgrid_attribs_sm.fypp \
                 specgrid_interp_sm.fypp specgrid_operate_sm.fypp specgrid_io_sm.fypp

specint_SRCS = specint_m.fypp specint_sm.fypp \
                limb_specint_m.fypp limb_specint_construct_sm.fypp limb_specint_attribs_sm.fypp \
                limb_specint_interp_sm.fypp limb_specint_operate_sm.fypp limb_specint_io_sm.fypp

specsource_SRCS = specsource_m.fypp \
                   hdf5_specsource_m.fypp hdf5_specsource_construct_sm.fypp \
                   hdf5_specsource_attribs_sm.fypp hdf5_specsource_access_sm.fypp

limb_SRCS = limb_m.fypp limb_construct_sm.fypp limb_attribs_sm.fypp limb_basis_sm.fypp \
            limb_fit_sm.fypp limb_io_sm.fypp

passband_SRCS = passband_m.fypp passband_construct_sm.fypp passband_attribs_sm.fypp \
                passband_passthru_sm.fypp passband_io_sm.fypp

range_SRCS = range_m.fypp range_sm.fypp \
             comp_range_m.fypp comp_range_construct_sm.fypp comp_range_attribs_sm.fypp \
             comp_range_operate_sm.fypp comp_range_io_sm.fypp \
             lin_range_m.fypp lin_range_construct_sm.fypp lin_range_attribs_sm.fypp \
             lin_range_operate_sm.fypp lin_range_io_sm.fypp \
             log_range_m.fypp log_range_construct_sm.fypp log_range_attribs_sm.fypp \
             log_range_operate_sm.fypp log_range_io_sm.fypp \
             tab_range_m.fypp tab_range_construct_sm.fypp tab_range_attribs_sm.fypp \
             tab_range_operate_sm.fypp tab_range_io_sm.fypp

libmsg_SRCS = msg_m.fypp \
              $(axis_SRCS) $(vgrid_SRCS) $(ninterp_SRCS) \
              $(photcache_SRCS) $(photgrid_SRCS) $(photint_SRCS) $(photsource_SRCS) \
              $(speccache_SRCS) $(specgrid_SRCS) $(specint_SRCS) $(specsource_SRCS) \
              $(limb_SRCS) $(passband_SRCS) $(range_SRCS) \
              cubint_m.fypp stat_m.fypp file_m.fypp	\
              fit_m.fypp math_m.fypp

libfmsg_SRCS = fmsg_m.fypp
libfmsg_USES = $(libmsg_SRCS)
libfmsg_LIBS = libmsg

libcmsg_SRCS = cmsg_m.fypp cmsg_spec_m.fypp cmsg_phot_m.fypp
libcmsg_USES = $(libmsg_SRCS)
libcmsg_LIBS = libmsg

pycmsg_SRCS = pycmsg.c
pycmsg_LIBS = libmsg libcmsg

ascii_to_specint_SRCS = ascii_to_specint.fypp
ascii_to_specint_USES = $(libmsg_SRCS)
ascii_to_specint_LIBS = libmsg

synspec_to_specint_SRCS = synspec_to_specint.fypp
synspec_to_specint_USES = $(libmsg_SRCS)
synspec_to_specint_LIBS = libmsg

ferre_to_specint_SRCS = ferre_to_specint.fypp
ferre_to_specint_USES = $(libmsg_SRCS)
ferre_to_specint_LIBS = libmsg

c3k_to_specint_SRCS = c3k_to_specint.fypp
c3k_to_specint_USES = $(libmsg_SRCS)
c3k_to_specint_LIBS = libmsg

goettingen_to_specint_SRCS = goettingen_to_specint.fypp tools_utils_m.fypp
goettingen_to_specint_USES = $(libmsg_SRCS)
goettingen_to_specint_LIBS = libmsg

coelho_to_specint_SRCS = coelho_to_specint.fypp tools_utils_m.fypp
coelho_to_specint_USES = $(libmsg_SRCS)
coelho_to_specint_LIBS = libmsg

parse_wavelen_SRCS = parse_wavelen.fypp
parse_wavelen_USES = $(libmsg_SRCS)
parse_wavelen_LIBS = libmsg

specint_to_specint_SRCS = specint_to_specint.fypp
specint_to_specint_USES = $(libmsg_SRCS)
specint_to_specint_LIBS = libmsg

specgrid_to_photgrid_SRCS = specgrid_to_photgrid.fypp
specgrid_to_photgrid_USES = $(libmsg_SRCS)
specgrid_to_photgrid_LIBS = libmsg

specint_to_specgrid_SRCS = specint_to_specgrid.fypp
specint_to_specgrid_USES = $(libmsg_SRCS)
specint_to_specgrid_LIBS = libmsg

make_photgrid_SRCS = make_photgrid.fypp
make_photgrid_USES = $(libmsg_SRCS)
make_photgrid_LIBS = libmsg

make_bb_photgrid_SRCS = make_bb_photgrid.fypp
make_bb_photgrid_USES = $(libmsg_SRCS)
make_bb_photgrid_LIBS = libmsg

make_passband_SRCS = make_passband.fypp
make_passband_USES = $(libmsg_SRCS)
make_passband_LIBS = libmsg

make_photon_passband_SRCS = make_photon_passband.fypp
make_photon_passband_USES = $(libmsg_SRCS)
make_photon_passband_LIBS = libmsg

inspect_grid_SRCS = inspect_grid.fypp
inspect_grid_USES = $(libmsg_SRCS)
inspect_grid_LIBS = libmsg

utest_file_SRCS = utest_file.fypp utest_file_m.fypp
utest_file_USES = $(libmsg_SRCS)
utest_file_LIBS = libmsg

utest_fit_SRCS = utest_fit.fypp utest_fit_m.fypp
utest_fit_USES = $(libmsg_SRCS)
utest_fit_LIBS = libmsg

utest_math_SRCS = utest_math.fypp utest_math_m.fypp
utest_math_USES = $(libmsg_SRCS)
utest_math_LIBS = libmsg

utest_cubint_SRCS = utest_cubint.fypp utest_cubint_m.fypp
utest_cubint_USES = $(libmsg_SRCS)
utest_cubint_LIBS = libmsg

utest_ninterp_SRCS = utest_ninterp.fypp utest_ninterp_m.fypp
utest_ninterp_USES = $(libmsg_SRCS)
utest_ninterp_LIBS = libmsg

utest_axis_SRCS = utest_axis.fypp utest_axis_m.fypp
utest_axis_USES = $(libmsg_SRCS)
utest_axis_LIBS = libmsg

utest_vgrid_SRCS = utest_vgrid.fypp utest_vgrid_m.fypp
utest_vgrid_USES = $(libmsg_SRCS)
utest_vgrid_LIBS = libmsg

utest_specgrid_SRCS = utest_specgrid.fypp utest_specgrid_m.fypp
utest_specgrid_USES = $(libmsg_SRCS) $(libfmsg_SRCS)
utest_specgrid_LIBS = libmsg libfmsg

utest_photgrid_SRCS = utest_photgrid.fypp utest_photgrid_m.fypp
utest_photgrid_USES = $(libmsg_SRCS) $(libfmsg_SRCS)
utest_photgrid_LIBS = libmsg libfmsg

stress_specgrid_SRCS = stress_specgrid.fypp
stress_specgrid_USES = $(libmsg_SRCS) $(libfmsg_SRCS)
stress_specgrid_LIBS = libmsg libfmsg

stress_photgrid_SRCS = stress_photgrid.fypp
stress_photgrid_USES = $(libmsg_SRCS) $(libfmsg_SRCS)
stress_photgrid_LIBS = libmsg libfmsg

time_vgrid_SRCS = time_vgrid.fypp
time_vgrid_USES = $(libmsg_SRCS) $(libfmsg_SRCS)
time_vgrid_LIBS = libmsg libfmsg

time_specgrid_SRCS = time_specgrid.fypp
time_specgrid_USES = $(libmsg_SRCS) $(libfmsg_SRCS)
time_specgrid_LIBS = libmsg libfmsg

# Build flags

FFLAGS = -I$(FORUM_INC_DIR)

FPPFLAGS = -I$(FORUM_INC_DIR)

LDFLAGS = `lapack_link` `hdf5_link` `lapack95_link` -L$(FORUM_LIB_DIR) -lforum

# Include standard rules

include Make.inc

# Target for linting

linter :
	fortitude check --file-extensions=f90

# Targets for source checking

check_src:
	@for src in $(libmsg_SRCS); do find ../$(SRC_DIRS) -name $$src | grep -q . || echo $$src MISSING; done

# Additional dependencies

pycmsg.o : cmsg.h

.PHONY: all linter check_src
