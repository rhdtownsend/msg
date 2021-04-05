# File     : Makefile
# Purpose  : top-level makefile

# Variables

BINDIR=${CURDIR}/bin
LIBDIR=${CURDIR}/lib

# Rules

all :
	@mkdir -p ${BINDIR}
	@mkdir -p ${LIBDIR}
	@${MAKE} --no-print-directory BINDIR=${BINDIR} LIBDIR=${LIBDIR} -C build install

test :
	@${MAKE} --no-print-directory BINDIR=${BINDIR} -C test $@

clean almostclean :
	@${MAKE} -w -C src $@
	rm -f ${BINDIR}/* ${LIBDIR}/*

.PHONY: all test build_ref build_ref_arch clean
