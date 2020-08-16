#!/bin/bash

# Fetch the inputs
if test $# -lt 1 ; then
  echo "USAGE: `basename $0` OUTPUT_DIR" ;
  exit 1 ;
fi
filesDir="$1" ;

# Create the output directory
outDir="${filesDir}/output" ;
mkdir -p ${outDir} ;

# Create the bitcode directory
bitcodeDir="${filesDir}/parallelized_bitcode" ;
mkdir -p ${bitcodeDir} ;

# Copy the text outputs ;
cp *.txt ${filesDir}/ ;

# Copy the makefile
cp makefiles/Makefile ${filesDir}/ ;

# Copy the files ;
for i in `find ./benchmarks -name noelle_output.txt` ; do
  echo "Copy $i" ;

  # Fetch the names
  benchDir=`dirname $i` ;
  benchName=`basename $benchDir` ;
  fileName=`basename $i` ;

  # Create the benchmark directory in the output directory
  mkdir -p ${outDir}/$benchDir ;

  # Copy the output
  cp $i ${outDir}/${benchDir}/$fileName ;

  # Copy the parallelized bitcode
  bitcodeFile="${benchDir}/${benchName}.bc" ;
  if test -f $bitcodeFile ; then
    mkdir -p ${bitcodeDir}/${benchDir} ;
    cp ${bitcodeFile} ${bitcodeDir}/${benchDir}/ ;
  fi
done
