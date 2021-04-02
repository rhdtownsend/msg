#!/bin/bash

echo "Extracting individual spectra..."

for d in nsc?; do

    echo "  $d"

    cd $d

    ../../../../build/ferre_to_specint f_$d.dat CAP18 spec-

    cd ..

done

echo "Building grid..."

../../../build/make_specgrid nsc?/*.h5 sg-cap18-coarse.h5

echo "Cleaing up..."

rm nsc?/*.h5

