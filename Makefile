# File     : Makefile
# Purpose  : top-level makefile

# Build test programs
TESTS ?= yes

# Build tool executables
TOOLS ?= yes

# Build ForUM internally. If not set to "yes", then
# you must set FORUM_LIB_DIR and FORUM_INC_DIR to
# point to where the ForUM library and module files,
# respectively, are located
FORUM ?= yes

# Enable debugging (with a performance penalty)
DEBUG ?= no

# Build & link against shared libraries
SHARED ?= yes

# Enable FPE checks
FPE ?= yes

# Enable OpenMP parallelization
OMP ?= yes

# Build Python interface
PYTHON ?= yes

# Link string for FITS library
# (leave undefined if not available)
FITS_LDFLAGS = -L/opt/local/lib -lcfitsio

############ DO NOT EDIT BELOW THIS LINE ############
### (unless you think you know what you're doing) ###
#####################################################

# General make settings

export

SH = /bin/bash
MAKEFLAGS += --no-print-directory

# Paths

BIN_DIR ?= $(CURDIR)/bin
LIB_DIR ?= $(CURDIR)/lib
INC_DIR ?= $(CURDIR)/include

SRC_DIR = $(CURDIR)/src
SRC_DIRS = $(addprefix $(SRC_DIR)/, axis common cython include ninterp lib limb math \
           range range/comp range/lin range/log range/tab \
           specsource \
           photcache photgrid \
           photint photint/limb \
           photsource photsource/hdf5 photsource/mem photsource/spec \
           passband \
           speccache specgrid \
           specint specint/limb \
           specsource specsource/hdf5 \
           tests tools vgrid indexer)

ifeq ($(FORUM),yes)
   FORUM_LIB_DIR = $(LIB_DIR)
   FORUM_INC_DIR = $(INC_DIR)
endif

# Rules

install : build | $(BIN_DIR) $(LIB_DIR) $(INC_DIR)
	@$(MAKE) -C build $@

build : install-forum
	@$(MAKE) -C build $@

clean : clean-forum
	@$(MAKE) -C build $@
	@rm -rf $(BIN_DIR) $(LIB_DIR) $(INC_DIR)

test :
	@$(MAKE) -C test $@

check_src :
	@$(MAKE) -C build $@

ifeq ($(FORUM),yes)

   install-forum : | $(BIN_DIR) $(LIB_DIR) $(INC_DIR)
	@$(MAKE) -C $(SRC_DIR)/forum

   clean-forum :
	@$(MAKE) -C $(SRC_DIR)/forum clean

   install-forum : TESTS = no

else

   install-forum : ;
   clean-forum : ;

endif

.PHONY: install build clean test check_src install-forum clean-forum

$(BIN_DIR) $(LIB_DIR) $(INC_DIR) :
	@mkdir -p $@
