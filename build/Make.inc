# File     : Make.inc
# Purpose  : standard makefile rules, targets

# The following flags can be edited (set to either yes or no)

# Enable debugging (with a performance penalty)
DEBUG?=no

# Enable OpenMP parallelization
OMP?=yes

# Enable FPE checks
FPE?=yes

############ DO NOT EDIT BELOW THIS LINE ############
### (unless you think you know what you're doing) ###
#####################################################

# Check SDK version

MINIMUM_VERSION = 20.3.2

ifneq ($(MAKECMDGOALS),clean)
  ifneq ($(shell ./check_sdk_version $(MINIMUM_VERSION)),passed)
    $(error Your MESASDK is too old please update to version $(MINIMUM_VERSION) or newer)
  endif
endif

# Preprocessor flags

OPTS=DEBUG OMP

FYPPFLAGS:=${FYPPFLAGS} $(foreach subdir,$(subst :, ,${SUBDIRS}),-I${subdir}) $(foreach opt,${OPTS},$(if $(filter yes,${${opt}}),-D${opt}))

# Shared library extension

ifeq ($(shell uname -s),Darwin)
  SHARED_LIB_EXT=dylib
else			   
  SHARED_LIB_EXT=so
endif

# Compiler settings

export F9XC

F9XC=gfortran

FFLAGS:=${FFLAGS} -finit-real=snan -fbacktrace -fmax-errors=25 -fPIC

ifeq (${FPE},yes)
  FFLAGS:=${FFLAGS} -ffpe-trap=invalid,overflow,zero
endif

ifeq (${DEBUG},yes)
  FFLAGS:=${FFLAGS} -fcheck=all -Wall -Wno-unused-dummy-argument -Wno-maybe-uninitialized -finline-limit=0 -ggdb
  FYPPFLAGS:=${FYPPFLAGS}
else
  FFLAGS:=${FFLAGS} -O2 -march=native
  FYPPFLAGS:=${FYPPFLAGS}
endif

F9XFLAGS:=${F9XFLAGS} $(addprefix -I,${MODPATH}) ${FFLAGS} -std=f2008
F77FLAGS:=${F77FLAGS} ${FFLAGS} -ffixed-form
LDFLAGS:=${LDFLAGS} `lapack95_link`

ifeq (${OMP},yes)
  F9XFLAGS:=${F9XFLAGS} -fopenmp
  F77FLAGS:=${F77FLAGS} -fopenmp
endif

export MESASDK_MATH_SLOT=crmath
LDFLAGS:=${LDFLAGS} `crmath_link` `crlibm_link`

F9XFLAGS:=${F9XFLAGS} -ffp-contract=off
F77FLAGS:=${F9XFLAGS} -ffp-contract=off

LDFLAGS:=${LDFLAGS} `hdf5_link`

# Cancel implicit rules

%.o : %.mod
% : %.mod
% : %.o

# Rules

vpath %.fypp ${SUBDIRS}
vpath %.inc ${SUBDIRS}

.PRECIOUS : %.f90

%.f90 %.dpp : %.fypp
	@./fypp_deps ${FYPPFLAGS} $< $*.f90 > $*.dpp

%.o %.mod : %.f90
	@echo FC $<
	@${F9XC} ${F9XFLAGS} ${MODINCS} -c $<
	@if [[ -e $*.mod ]]; then touch $*.mod; fi

all : ${TARGETS}

install : ${TARGETS}
	@for t in ${TARGETS}; do \
            echo CP $${t} ${BINDIR}; \
            cp $${t} ${BINDIR}; \
        done

clean :
	rm -f ${TARGETS} $(addsuffix .f90,${TARGETS}) *.o *.mod *.smod *.f90 *.d *.dpp

almostclean :
	rm -f ${TARGETS} $(addsuffix .f90,${TARGETS}) *.o *.mod *.smod *.f90

# Dependency handling

ifneq ($(MAKECMDGOALS),clean)
-include $(addsuffix .d,${TARGETS})
endif

.SECONDEXPANSION:

ifeq ($(shell uname -s),Darwin)
  %.${SHARED_LIB_EXT} : LIB_LDFLAGS=-shared -install_name @rpath/$@
else			   
  %.${SHARED_LIB_EXT} : LIB_LDFLAGS=-shared
endif

${TARGETS}: $$(subst .f90,.o,$$($$@_SRCS))
	@echo LD $@
	${F9XC} ${F9XFLAGS} -o $@ $^ ${LDFLAGS} ${LIB_LDFLAGS}

%.d : $$($$*_SRCS)
	@echo DEPEND $@
	@./makedepf90_deps $@ $^ > $@
