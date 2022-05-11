#!/bin/bash

if [[ `uname -s` == 'Darwin' ]]; then
    make_writeable=1
    mode_save=`stat -f '%A' .`
fi

if [[ -n $make_writeable ]]; then
    echo 'making directory writable'
    chmod o+w .
    rm -f paper.jats paper.pdf
fi

docker run --rm \
    --volume $PWD:/data \
    --user $(id -u):$(id -g) \
    --env JOURNAL=joss \
    openjournals/inara

if [[ -n $make_writeable ]]; then
    chmod $mode_save .
fi


