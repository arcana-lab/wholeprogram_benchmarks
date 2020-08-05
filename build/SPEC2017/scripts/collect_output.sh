#!/bin/bash

# Fetch the inputs
if test $# -lt 1 ; then
  echo "USAGE: `basename $0` OUTPUT_DIR" ;
  exit 1 ;
fi
outDir="$1" ;

# Create the output directory
mkdir -p ${outDir} ;

# Copy the outputs
for i in `find ./benchmarks -name noelle_output.txt` ; do
  echo "Copy $i" ;

  # Create the benchmark directory in the output directory
  benchDir=`dirname $i` ;
  mkdir -p ${outDir}/$benchDir ;

  # Copy the output
  fileName=`basename $i` ;
  cp $i ${outDir}/${benchDir}/$fileName ;

done
