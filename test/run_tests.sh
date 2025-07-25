#!/bin/sh

rm -f test.out

for t in ${BIN_DIR}/utest_*; do
    $t | tee -a test.out
done

echo "==============="
echo " Passes:   " `grep -c PASS test.out`
echo " Failures: " `grep -c FAIL test.out`
echo "==============="
