# File     : Make.inc
# Purpose  : standard makefile rules, targets

#########
# Checks
#########

MINIMUM_VERSION = 21.4.1

ifneq ($(MAKECMDGOALS),clean)

   VERSION_CHECK = $(shell ./check_sdk_version $(MINIMUM_VERSION))

   ifneq ($(VERSION_CHECK),passed)
      ifeq ($(VERSION_CHECK),SDK too old)
         $(error Your MESA SDK installation is too old; please update to version $(MINIMUM_VERSION) or newer)
      else ifeq ($(VERSION_CHECK),SDK not installed)
         $(error MESA SDK is either not installed or not properly initialized)
      else
         $(error Could not determine MESA SDK availability)
      endif
   endif

   ifeq ($(MSG_DIR),) 
       $(error Please set the MSG_DIR environment variable to point to the top-level MSG directory)
   endif

endif

############
# Variables
############

ifeq ($(shell uname -s),Darwin)
   LIB_SUFFIX = .dylib
   PYC_SUFFIX = $(shell python3-config --extension-suffix)
else			   
   LIB_SUFFIX = .so
   PYC_SUFFIX = $(shell python3-config --extension-suffix)
endif

DEPEND_DIR = .depend

BIN_FILES = $(BIN_TARGETS)

LIB_FILES = $(addsuffix $(LIB_SUFFIX),$(LIB_TARGETS))

PYC_FILES = $(addsuffix $(PYC_SUFFIX),$(PYC_TARGETS))

ALL_SRCS = $(foreach target,$(BIN_TARGETS) $(LIB_TARGETS) $(PYC_TARGETS),$($(target)_SRCS) $($(target)_USES))

ALL_DPPS = $(addprefix $(DEPEND_DIR)/,$(ALL_SRCS:%.fypp=%.dpp))
ALL_DEPS = $(addprefix $(DEPEND_DIR)/,$(BIN_TARGETS:%=%.dep) $(LIB_TARGETS:%=%.dep))

##########
# Targets
##########

all : $(BIN_FILES) $(LIB_FILES) $(PYC_FILES)
	@:

install : $(addprefix $(BIN_DIR)/,$(BIN_FILES)) \
          $(addprefix $(LIB_DIR)/,$(LIB_FILES)) \
          $(addprefix $(LIB_DIR)/,$(PYC_FILES)) \
          $(addprefix $(INC_DIR)/,$(INC_FILES))
	@:

clean :
	@rm -rf $(BIN_FILES) $(SLIB_FILES) \
                $(INC_FILES) $(DEPEND_DIR) *.f90 *.mod *.smod *.o

$(BIN_DIR)/% : %
	@echo CP $* $@
	@cp $< $@

$(LIB_DIR)/% : %
	@echo CP $* $@
	@cp $< $@

$(INC_DIR)/% : %
	@echo CP $* $@
	@cp $< $@

$(DEPEND_DIR) :
	@mkdir -p $@

.PHONY: all install clean

.SUFFIXES:

########
# Paths
########

vpath %.fypp $(SRC_DIRS)
vpath %.inc $(SRC_DIRS)
vpath %.h $(SRC_DIRS)
vpath %.c $(SRC_DIRS)
vpath %.pyx $(SRC_DIRS)

#################
# Preproccessing
#################

# Flags

FPP = PYTHONPATH=$(MESASDK_ROOT)/lib/python ./fypp_deps

FPPFLAGS += --line-numbering $(addprefix -I,$(SRC_DIRS)) \
            $(foreach opt,DEBUG OMP FPE,$(if $(filter yes,$($(opt))),-D$(opt)=1,-D$(opt)=0))

ifeq ($(DEBUG),yes)
   FPPFLAGS += -DLOG_LEVEL=\'DEBUG\'
else
   FPPFLAGS += -DLOG_LEVEL=\'INFO\'
endif

# Rules

%.f90 : %.fypp | $(DEPEND_DIR)
	@$(FPP) $(FPPFLAGS) -d $(DEPEND_DIR)/$*.dpp $< $@

$(ALL_DPPS) : 

# Include generated dependencies from .dpp files

ifneq ($(MAKECMDGOALS),clean)
   -include $(ALL_DPPS)
endif

############
# Compiling
############

# Fortran flags

FC = gfortran

MAKEDEP = awk -f makedepf08.awk

FFLAGS += -std=f2018 -finit-real=snan -fbacktrace -fmax-errors=25 -fPIC

ifeq ($(FPE),yes)
   FFLAGS += -ffpe-trap=invalid,overflow,zero
endif

ifeq ($(DEBUG),yes)
   FFLAGS += -Og -ggdb -fcheck=all \
             -Wall -Wno-unused-dummy-argument -Wno-maybe-uninitialized \
             -finline-limit=0
else
   FFLAGS += -O2
endif

ifeq ($(OMP),yes)
   FFLAGS += -fopenmp
endif

ifeq ($(PORTABLE),yes)
   FFLAGS += -ffp-contract=off
else
   FFLAGS += -march=native
endif

# C flags

CC = gcc

CFLAGS += -fPIC -I../src/include

ifeq ($(DEBUG),yes)
  CFLAGS += -Og -ggdb
else
  CFLAGS += -O2 -march=native -Wno-cpp
endif

ifeq ($(PYTHON),yes)
  CFLAGS += $(shell python3-config --includes) -I$(shell python3 -c 'import numpy; print(numpy.get_include())')
endif

ifeq ($(shell uname -s),Linux)
  LDFLAGS += -Wl,--no-warn-execstack
endif

# Cython flags

CYTHON = cython

CYFLAGS = -I../src/include

# Rules

%.o : $(DEPEND_DIR)/%.anc
	@echo FC $*
	@$(FC) $(FFLAGS) -c $*.f90

$(DEPEND_DIR)/%.anc : %.f90 | $(DEPEND_DIR)
	@$(FC) $(FFLAGS) -fsyntax-only -c $*.f90
	@touch $@

%.o : %.c
	@echo CC $<
	@$(CC) $(CFLAGS) -c $<

%.c : %.pyx
	@echo CYTHON $<
	@$(CYTHON) $(CYFLAGS) -o $@ $<

$(ALL_DEPS) : | $(DEPEND_DIR)
	@echo MAKEDEP $*
	@$(MAKEDEP) $^ > $@

# Include generated dependencies from .dep files

ifneq ($(MAKECMDGOALS),clean)
   -include $(ALL_DEPS)
endif

##########
# Linking
##########

# Flags

ifeq ($(shell uname -s),Darwin)
   LIB_LDFLAGS = -shared -install_name $(LIB_DIR)/$@
   BIN_LDFLAGS =
   PYC_LDFLAGS = -shared -install_name $(MSG_DIR)/python/$@ -undefined dynamic_lookup
else			   
   LIB_LDFLAGS = -Wl,--no-warn-execstack -shared -Wl,-rpath -Wl,$(LIB_DIR)
   BIN_LDFLAGS = -Wl,--no-warn-execstack -Wl,-rpath -Wl,$(LIB_DIR)
   PYC_LDFLAGS = $(LIB_LDFLAGS)
endif

# Rules

$(BIN_FILES) :
	@echo LD $@
	@$(FC) $(FFLAGS) -o $@ $^ $(LDFLAGS) $(BIN_LDFLAGS)

$(LIB_FILES) :
	@echo LD-LIB $@
	@$(FC) $(FFLAGS) -o $@ $^ $(LDFLAGS) $(LIB_LDFLAGS)

$(PYC_FILES) :
	@echo LD_PYC $@
	@$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS) $(PYC_LDFLAGS)

#######################
# Secondary Expansions
#######################

.SECONDEXPANSION :

$(BIN_FILES) : % : $$(subst .fypp,.o,$$($$*_SRCS)) $$(addsuffix $(LIB_SUFFIX),$$($$*_LIBS))

$(LIB_FILES) : %$(LIB_SUFFIX) : $$(subst .fypp,.o,$$($$*_SRCS)) $$(addsuffix $(LIB_SUFFIX),$$($$*_LIBS))

$(PYC_FILES) : %$(PYC_SUFFIX) : $$(subst .c,.o,$$($$*_SRCS)) $$(addsuffix $(LIB_SUFFIX),$$($$*_LIBS))

$(ALL_DEPS) : $(DEPEND_DIR)/%.dep : $$(subst .fypp,.f90,$$($$*_SRCS) $$($$*_USES))
