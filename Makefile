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

# Enable FPE checks
FPE ?= yes

# Enable OpenMP parallelization
OMP ?= yes

# Build Python interface
PYTHON ?= yes

# Link string for FITS library
# (leave undefined if not available)
#FITS_LDFLAGS = -L/opt/local/lib -lcfitsio

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
SRC_DIRS = $(addprefix $(SRC_DIR)/, common cython include lib math phot \
           range spec tests tools vgrid)

ifeq ($(FORUM),yes)
   FORUM_LIB_DIR = $(LIB_DIR)
   FORUM_INC_DIR = $(INC_DIR)
endif

# Rules

all : install-forum
	@$(MAKE) -C build

install : all | $(BIN_DIR) $(LIB_DIR) $(INC_DIR)
	@$(MAKE) -C build install

clean : clean-forum
	@$(MAKE) -C build clean
	@rm -rf $(BIN_DIR) $(LIB_DIR) $(INC_DIR)

test :
	@$(MAKE) --no-print-directory -C test $@

ifeq ($(FORUM),yes)

   install-forum : | $(BIN_DIR) $(LIB_DIR) $(INC_DIR)
	@$(MAKE) -C $(SRC_DIR)/forum install

   clean-forum :
	@$(MAKE) -C $(SRC_DIR)/forum clean

else

   install-forum : ;
   clean-forum : ;

endif

.PHONY: all install clean test install-forum clean-forum

$(BIN_DIR) $(LIB_DIR) $(INC_DIR) :
	@mkdir -p $@
