# File     : Makefile
# Purpose  : top-level makefile

# Build test programs
export TESTS ?= yes

# Build tool executables
export TOOLS ?= yes

# Link against an external ForUM library
#
# If set to "yes", then the build system will use pkgconf to search
# for library, with a package name speficied by EXTERNAL_FORUM_PKG.
# Otherwise, the ForUM library will be built and linked internally
EXTERNAL_FORUM ?= no
EXTERNAL_FORUM_PKG ?= forum

# Enable debugging (with a performance penalty)
export DEBUG ?= no

# Build & link against shared libraries
export SHARED ?= yes

# Enable FPE checks
export FPE ?= yes

# Enable OpenMP parallelization
export OMP ?= yes

# Build Python interface
export PYTHON ?= yes

# Link string for FITS library
# (leave undefined if not available)
#export FITS_LDFLAGS = -L/opt/local/lib -lcfitsio

############ DO NOT EDIT BELOW THIS LINE ############
### (unless you think you know what you're doing) ###
#####################################################

# General make settings

SH = /bin/bash
MAKEFLAGS += --no-print-directory

# Paths

export BIN_DIR ?= $(CURDIR)/bin
export LIB_DIR ?= $(CURDIR)/lib
export PKG_DIR ?= $(LIB_DIR)/pkgconfig
export INC_DIR ?= $(CURDIR)/include

export SRC_DIR := $(CURDIR)/src
export SRC_DIRS =: $(addprefix $(SRC_DIR)/, \
     axis common cython include indexer lib limb \
     math ninterp passband photcache photgrid \
     photint photint/limb \
     photsource photsource/hdf5 photsource/mem photsource/spec \
     range range/comp range/lin range/log range/tab \
     speccache specgrid \
     specint specint/limb \
     specsource specsource/hdf5 \
     tests tools vgrid)

# Rules

install : build | $(BIN_DIR) $(LIB_DIR) $(PKG_DIR) $(INC_DIR)
	@$(MAKE) -C build $@

build : install-forum
	@$(MAKE) -C build $@

clean : clean-forum
	@$(MAKE) -C build $@
	@rm -rf $(BIN_DIR) $(LIB_DIR) $(PKG_DIR) $(INC_DIR)

test :
	@$(MAKE) -C test $@

check_src :
	@$(MAKE) -C build $@

ifneq ($(EXTERNAL_FORUM),yes)

   install-forum : | $(BIN_DIR) $(LIB_DIR) $(PKG_DIR) $(INC_DIR)
	@$(MAKE) -C $(SRC_DIR)/forum

   clean-forum :
	@$(MAKE) -C $(SRC_DIR)/forum clean

   install-forum : TESTS = no

else

   install-forum : ;
   clean-forum : ;

endif

.PHONY: install build clean test check_src install-forum clean-forum

$(BIN_DIR) $(LIB_DIR) $(PKG_DIR) $(INC_DIR) :
	@mkdir -p $@
