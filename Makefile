# File     : Makefile
# Purpose  : top-level makefile

# Variables

BINDIR=${CURDIR}/bin
LIBDIR=${CURDIR}/lib
PYCDIR=${CURDIR}/python/pymsg
INCDIR=${CURDIR}/include

# Rules

all :
	@mkdir -p ${BINDIR} ${LIBDIR} ${INCDIR}
	@${MAKE} --no-print-directory BINDIR=${BINDIR} LIBDIR=${LIBDIR} PYCDIR=${PYCDIR} INCDIR=${INCDIR} -C build install

test :
	@${MAKE} --no-print-directory BINDIR=${BINDIR} -C test $@

clean almostclean :
	@${MAKE} -w -C build $@
	rm -f ${BINDIR}/* ${LIBDIR}/* ${INCDIR}/*

.PHONY: all test build_ref build_ref_arch clean
