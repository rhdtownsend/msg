#!/bin/sh

./filter_to_ascii.py

../../../build/make_passband kepler.txt 0. pb-kepler.h5
