#!/bin/bash

# Get benchmark directory
benchmarkDir="$1" ;

# Check that benchmark dir exists
if ! test -d ${benchmarkDir} ; then
  echo "ERROR: ${benchmarkDir} not found." ;
  exit 1 ;
fi

# Go to benchmark dir
cd ${benchmarkDir} ;

# Compile benchmark
make clean &> /dev/null ;
make CC=gclang CXX=gclang++ ;
