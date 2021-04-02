#!/bin/sh

base_url=http://cdsarc.u-strasbg.fr/ftp/J/A+A/618/A25/nsc/

echo "Fetching files..."

for d in nsc1 nsc2 nsc3 nsc4 nsc5; do

    cd $d

    file=f_${d}.dat.bz2
    echo "  $file"

    curl ${base_url}/${file} -o ${file}

    bzip2 -d ${file}

    cd ..

done    
