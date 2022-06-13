#!/bin/bash

# Get benchmark directory
benchmarkDir="$1" ;
benchmark="$2" ;

# Check that benchmark dir exists
if ! test -d ${benchmarkDir} ; then
  echo "ERROR: ${benchmarkDir} not found." ;
  exit 1 ;
fi

# Go to benchmark dir
cd ${benchmarkDir} ;

# Compile benchmark
make clean ;
if test "$benchmark" == "BT" || test "$benchmark" == "FT" ; then
  make CC=gclang CXX=gclang++ CLASS=B $benchmark ;
else
  make CC=gclang CXX=gclang++ CLASS=B $benchmark ;
fi
