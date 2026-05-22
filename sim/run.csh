#!/bin/csh

# Optimized test runner for QuestaSim
# Usage:
#   ./run.csh           # Run all tests with coverage
#   ./run.csh no-cov    # Run all tests without coverage

set cov = 1

if( ($#argv > 0) && ("$1" == "no-cov") ) then
    set cov = 0
endif

make clean

echo "Running all testcases from pat.list..."

foreach pat (`cat pat.list | sed '\/\//d'`)
    echo "========================================="
    echo "Running testcase: $pat"
    echo "========================================="
    
    if( $cov ) then
        make all_cov TESTNAME=${pat}
    else
        make all TESTNAME=${pat}
    endif
end

echo "========================================="

if( $cov ) then
    echo "Generating coverage report..."
    make gen_cov
    echo "Text report: coverage/summary_report.txt"
endif

echo "Done!"
