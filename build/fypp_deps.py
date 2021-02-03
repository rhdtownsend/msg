#!/usr/bin/env python3
#
# Wrapper around the fypp Fortran pre-processor, that writes dependency
# information to STDOUT

import re
import sys
import fypp

incfiles = {}

class FyppDeps (fypp.Fypp):

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self._preprocessor._parser.handle_include = self.handle_include_and_add_dep
        self.incfiles = {}

    def handle_include_and_add_deps (self, span, fname):
        if span is not None:
            if fname in incfiles:
                self.incfiles[fname] += [span]
            else:
                self.incfiles[fname] = [span]
        self._preprocessor._builder.handle_include(span, fname)

def run_fypp_deps():

    options = fypp.FyppOptions()
    optparser = fypp.get_option_parser()
    opts, leftover = optparser.parse_args(values=options)
    infile = leftover[0] if len(leftover) > 0 else '-'
    outfile = leftover[1] if len(leftover) > 1 else '-'

    try:
        tool = FyppDeps(opts)
        tool.process_file(infile, outfile)
        print('{:s} : {:s} {:s}'.format(outfile, infile, ' '.join(tool.incfiles.keys())))
    except FyppStopRequest as exc:
        sys.stderr.write(_formatted_exception(exc))
        sys.exit(USER_ERROR_EXIT_CODE)
    except FyppFatalError as exc:
        sys.stderr.write(_formatted_exception(exc))
        sys.exit(ERROR_EXIT_CODE)

if __name__ == '__main__':
    sys.exit(run_fypp_deps())
