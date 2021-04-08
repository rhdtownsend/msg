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

MINIMUM_VERSION = 21.4.1

ifneq ($(MAKECMDGOALS),clean)
  ifneq ($(shell ./check_sdk_version $(MINIMUM_VERSION)),passed)
    $(error Your MESASDK is too old; please update to version $(MINIMUM_VERSION) or newer)
  endif
endif

# Preprocessor flags

OPTS = DEBUG OMP FPE

FYPPFLAGS:=${FYPPFLAGS} $(foreach subdir,$(subst :, ,${SUBDIRS}),-I${subdir}) $(foreach opt,${OPTS},$(if $(filter yes,${${opt}}),-D${opt}))

# Compiler settings

# Fortran

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

# C (mainly for Python extensions)

export CC

CC = gcc

CFLAGS := -fPIC -I../src/include

ifeq (${DEBUG},yes)
  CFLAGS := ${CFLAGS} -ggdb
else
  CFLAGS := ${CFLAGS} -O2 -march=native
endif

ifeq (${PYTHON},yes)
  CFLAGS := ${CFLAGS} $(shell python-config --inc)
endif

# Cython

export CYTHON

CYTHON = cython

CYFLAGS = -I../src/include

# Linking

LDFLAGS = `hdf5_link` `lapack95_link`

ifeq ($(shell uname -s),Darwin)
  LIB_SUFFIX = .dylib
  LIB_LDFLAGS = -shared -install_name ${MSG_DIR}/lib/$@
  PYM_SUFFIX = $(shell python-config --extension-suffix)
  PYM_LDFLAGS = ${LIB_LDFLAGS} -undefined dynamic_lookup 
else			   
  LIB_SUFFIX = .so
  LIB_LDFLAGS = -shared
  PYM_SUFFIX = $(shell python-config --extension-suffix)
  PYM_LDFLAGS = ${LIB_LDFLAGS} -undefined dynamic_lookup 
endif

# Targets-related variables

LIB_TARGETS_ = $(addsuffix ${LIB_SUFFIX},${LIB_TARGETS})
PYM_TARGETS_ = $(addsuffix ${PYM_SUFFIX},${PYM_TARGETS})

DEP_TARGETS = $(patsubst %,.%.d,${LIB_TARGETS} ${EXEC_TARGETS})

MOD_TARGETS = $(patsubst lib%,%_m.mod,${LIB_TARGETS})
INC_TARGETS = $(patsubst lib%,%.h,$(filter libc%,${LIB_TARGETS}))

# Paths

vpath %.fypp ${SUBDIRS}
vpath %.inc ${SUBDIRS}
vpath %.pyx ${SUBDIRS}
vpath %.c ${SUBDIRS}
vpath %.h ../src/include

# Explicit rules

.PHONY: all install lib-install exec-install headers-install clean almostclean

all : ${LIB_TARGETS_} ${PYM_TARGETS_} ${EXEC_TARGETS}

install : lib-install pym-install exec-install headers-install

lib-install : ${LIB_TARGETS_}
	@for t in $^; do \
            echo CP $${t} ${LIBDIR}; \
            cp $${t} ${LIBDIR}; \
        done

pym-install : ${PYM_TARGETS_}
	@for t in $^; do \
            echo CP $${t} ${LIBDIR}; \
            cp $${t} ${LIBDIR}; \
        done

exec-install : ${EXEC_TARGETS}
	@for t in $^; do \
            echo CP $${t} ${BINDIR}; \
            cp $${t} ${BINDIR}; \
        done

headers-install : ${MOD_TARGETS} ${INC_TARGETS}
	@for t in $^; do \
            echo CP $${t} ${INCDIR}; \
            cp $${t} ${INCDIR}; \
        done

clean : almostclean
	rm -f .*.d .*.dpp

almostclean :
	rm -f ${LIB_TARGETS_} ${PYM_TARGETS_} ${EXEC_TARGETS} *.o *.mod *.smod *.f90 *.c

${LIB_TARGETS_} :
	@echo LD_LIB $@
	@${F9XC} ${F9XFLAGS} -o $@ $^ ${LDFLAGS} ${LIB_LDFLAGS}

${PYM_TARGETS_} :
	@echo LD_PYM $@
	@${CC} ${CFLAGS} -o $@ $^ ${LDFLAGS} ${PYM_LDFLAGS}

${EXEC_TARGETS} :
	@echo LD $@
	@${F9XC} ${F9XFLAGS} -o $@ $^

${DEP_TARGETS} : 
	@echo DEPEND $(patsubst .%.d,%,$@) "->" $@
	@makedepf90 $(addprefix -d ,${EXTRA_DEPS}) -m %m.mod $^ > $@
	@echo "include \$$(patsubst %.f90,.%.dpp,$^)" >> $@

# Implicit rules

%.o : %.mod
%.o : %.c
% : %.mod
% : %.o

%.f90 .%.dpp : %.fypp
	@./fypp_deps ${FYPPFLAGS} $< $*.f90 > .$*.dpp

%.o %.mod : %.f90
	@echo FC $<
	@${F9XC} ${F9XFLAGS} -c $<
	@if [[ -e $*.mod ]]; then touch $*.mod; fi

%.c : %.pyx
	@echo CYTHON $<
	@$(CYTHON) $(CYFLAGS) -o $@ $<

%.o : %.c
	@echo CC $<
	@${CC} ${CFLAGS} -c $<

%.d : EXTRA_DEPS = $(addsuffix .mod,${$*_DEPS})

.PRECIOUS : %.f90 %.c

# Macros

strip_d = $(patsubst %.d,%,$(1))

# Dependency handling

ifneq ($(MAKECMDGOALS),clean)
-include ${DEP_TARGETS}
endif

.SECONDEXPANSION:

${LIB_TARGETS_} : %${LIB_SUFFIX} : $${$$*_OBJS} $$(addsuffix ${LIB_SUFFIX},$${$$*_LIBS})

${PYM_TARGETS_} : %${PYM_SUFFIX} : $${$$*_OBJS} $$(addsuffix ${LIB_SUFFIX},$${$$*_LIBS})

${EXEC_TARGETS} : $$($$@_OBJS) $$(addsuffix ${LIB_SUFFIX},$${$$@_LIBS})

${DEP_TARGETS} : .%.d : $$(subst .o,.f90,$${$$*_OBJS})
