#!/usr/bin/env bash
if grep "FAIL" test_output/summary.log
then
    # code if found
    echo "TEST FAILED"
    exit 1
else
    # code if not found
    echo "TEST PASSED"
    exit 0
fi
