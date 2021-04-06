# File     : Make.inc
# Purpose  : standard makefile rules, targets

# The following flags can be edited (set to either yes or no)

# Enable debugging (with a performance penalty)
DEBUG ?= no

# Enable OpenMP parallelization
OMP ?= yes

# Enable FPE checks
FPE ?= yes

############ DO NOT EDIT BELOW THIS LINE ############
### (unless you think you know what you're doing) ###
#####################################################

# Check MSG_DIR is set

ifneq ($(MAKECMDGOALS),clean)
  ifeq (${MSG_DIR},) 
    $(error Please set the MSG_DIR environment variable to point to the top-level MSG directory)
  endif
endif

# Check SDK version

MINIMUM_VERSION = 20.3.2

ifneq ($(MAKECMDGOALS),clean)
  ifneq ($(shell ./check_sdk_version $(MINIMUM_VERSION)),passed)
    $(error Your MESASDK is too old; please update to version $(MINIMUM_VERSION) or newer)
  endif
endif

# Preprocessor flags

OPTS = DEBUG OMP FPE

FYPPFLAGS:=${FYPPFLAGS} $(foreach subdir,$(subst :, ,${SUBDIRS}),-I${subdir}) $(foreach opt,${OPTS},$(if $(filter yes,${${opt}}),-D${opt}))

# Compiler settings

export F9XC

F9XC = gfortran

FFLAGS := ${FFLAGS} -finit-real=snan -fbacktrace -fmax-errors=25 -fPIC

ifeq (${FPE},yes)
  FFLAGS := ${FFLAGS} -ffpe-trap=invalid,overflow,zero
endif

ifeq (${DEBUG},yes)
  FFLAGS := ${FFLAGS} -fcheck=all -Wall -Wno-unused-dummy-argument -Wno-maybe-uninitialized -finline-limit=0 -ggdb
else
  FFLAGS := ${FFLAGS} -O2 -march=native
endif

F9XFLAGS := ${F9XFLAGS} $(addprefix -I,${MODPATH}) ${FFLAGS} -std=f2008
F77FLAGS := ${F77FLAGS} ${FFLAGS} -ffixed-form

ifeq (${OMP},yes)
  F9XFLAGS := ${F9XFLAGS} -fopenmp
  F77FLAGS := ${F77FLAGS} -fopenmp
endif

LDFLAGS := ${LDFLAGS} `hdf5_link` `lapack95_link`

ifeq ($(shell uname -s),Darwin)
  SHARED_LIB_EXT = dylib
  LIB_LDFLAGS = -shared -install_name ${MSG_DIR}/lib/$@
else			   
  SHARED_LIB_EXT = so
  LIB_LDFLAGS = -shared
endif

# Targets-related variables

LIB_TARGETS = $(filter lib%,${TARGETS})
LIB_EXT_TARGETS = $(addsuffix .${SHARED_LIB_EXT},${LIB_TARGETS})

INC_TARGETS = $(addsuffix .h,$(filter libc%,${LIB_TARGETS}))
MOD_TARGETS = $(addsuffix _m.mod,${LIB_TARGETS})

EXEC_TARGETS = $(filter-out lib%,${TARGETS})

DEP_TARGETS = $(patsubst %,.%.d,${TARGETS})
OBJ_TARGETS = $(addsuffix .o,${TARGETS})

# Paths

vpath %.fypp ${SUBDIRS}
vpath %.inc ${SUBDIRS}
vpath %.h ${SUBDIRS}

# Explicit rules

.PHONY: all install lib-install  mod-install exec-install clean almostclean

all : ${LIB_EXT_TARGETS} ${EXEC_TARGETS}

install : lib-install inc-install mod-install exec-install

lib-install : ${LIB_EXT_TARGETS}
	@for t in $^; do \
            echo CP $${t} ${LIBDIR}; \
            cp $${t} ${LIBDIR}; \
        done

mod-install : ${MOD_TARGETS}
	@for t in $^; do \
            echo CP $${t} ${INCDIR}; \
            cp $${t} ${INCDIR}; \
        done

inc-install : ${INC_TARGETS}
	@for t in $^; do \
            echo CP $${t} ${INCDIR}; \
            cp $${t} ${INCDIR}; \
        done

exec-install : ${EXEC_TARGETS}
	@for t in $^; do \
            echo CP $${t} ${BINDIR}; \
            cp $${t} ${BINDIR}; \
        done

clean : almostclean
	rm -f .*.d .*.dpp

almostclean :
	rm -f ${LIB_EXT_TARGETS} ${EXEC_TARGETS} *.o *.mod *.smod *.f90

${LIB_EXT_TARGETS} :
	@echo LD_LIB $@
	@${F9XC} ${F9XFLAGS} -o $@ $^ ${LDFLAGS} ${LIB_LDFLAGS}

${EXEC_TARGETS} :
	@echo LD $@
	@${F9XC} ${F9XFLAGS} -o $@ $^ ${LDFLAGS}

${DEP_TARGETS} : 
	@echo DEPEND $(patsubst .%.d,%,$@) "->" $@
	@makedepf90 $(addprefix -d ,${EXTRA_DEPS}) -m %m.mod $^ > $@
	@echo "include \$$(patsubst %.f90,.%.dpp,$^)" >> $@

# Implicit rules

%.o : %.mod
% : %.mod
% : %.o

%.f90 .%.dpp : %.fypp
	@./fypp_deps ${FYPPFLAGS} $< $*.f90 > .$*.dpp

%.o %.mod : %.f90
	@echo FC $<
	@${F9XC} ${F9XFLAGS} ${MODINCS} -c $<
	@if [[ -e $*.mod ]]; then touch $*.mod; fi

%.d : EXTRA_DEPS = $(addsuffix _m.mod,${$*_LIBS})

.PRECIOUS : %.f90

# Macros

strip_d = $(patsubst %.d,%,$(1))

# Dependency handling

ifneq ($(MAKECMDGOALS),clean)
-include ${DEP_TARGETS}
endif

.SECONDEXPANSION:

${LIB_EXT_TARGETS} : %.${SHARED_LIB_EXT} : $${$$*_OBJS} $$(addsuffix .${SHARED_LIB_EXT},$${$$*_LIBS})

${EXEC_TARGETS} : $$($$@_OBJS) $$(addsuffix .${SHARED_LIB_EXT},$${$$@_LIBS})

${DEP_TARGETS} : .%.d : $$(subst .o,.f90,$${$$*_OBJS})

