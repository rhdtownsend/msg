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

# Compiler settings

export F9XC

F9XC=gfortran

FFLAGS:=${FFLAGS} -finit-real=snan -fbacktrace -fmax-errors=25

ifeq (${FPE},yes)
  FFLAGS:=${FFLAGS} -ffpe-trap=invalid,overflow,zero
endif

ifeq (${DEBUG},yes)
  FFLAGS:=${FFLAGS} -fcheck=all -Wall -Wno-unused-dummy-argument -Wno-maybe-uninitialized -finline-limit=0 -ggdb
  FYPPFLAGS:=${FYPPFLAGS}PX3FLAGS}
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

# Rules

vpath %.fypp ${SUBDIRS}
vpath %.inc ${SUBDIRS}

.PRECIOUS : %.f90

%.o : %.mod # This cancels the default m2c rule

%.f90 : %.fypp
	@./fypp_deps.py ${FYPPFLAGS} $< $*.f90 > .$*.dpp

.%.dpp : %.f90
	@true

%.o : %.f90
	@echo FC $<
	@${F9XC} ${F9XFLAGS} ${MODINCS} -c $<

%.mod : %.o
	@true

%.smod : %.o
	@true

all : ${TARGETS}

install : ${TARGETS}
	@for t in ${TARGETS}; do \
            echo CP $${t} ${BINDIR}; \
            cp $${t} ${BINDIR}; \
        done

clean :
	rm -f ${TARGETS} $(addsuffix .f90,${TARGETS}) *.o *.mod *.smod *.f90 .*.d .*.dpp

almostclean :
	rm -f ${TARGETS} $(addsuffix .f90,${TARGETS}) *.o *.mod *.smod *.f90

# Dependency handling

ifneq ($(MAKECMDGOALS),clean)
-include $(addprefix .,$(subst .fypp,.dpp,${TARGETS}))
-include $(addprefix .,$(addsuffix .d,${TARGETS}))
endif

# Secondary expansion stuff

.SECONDEXPANSION:

.%.d : $$(subst .fypp,.f90,$$(%_SRCS))
	@makedepf90 \
            -m %m.mod \
            -o $* \
            -l '@echo LD $*; $${F9XC} $${F9XFLAGS} -o $$@ $$^ $${LDFLAGS}' \
            $^ | \
	    sed -e "s/FOBJ/$*_FOBJ/g" > $@
