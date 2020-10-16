#!/bin/bash

# Get benchmark suite dir
PWD_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/.." ;
benchmarkSuiteName="polybench-3.1" ;

# Get a list of all generated binaries, we'll use it to extract bitcode files
bitcodesDir="${PWD_PATH}/${benchmarkSuiteName}" ;

# Check if bitcode dir exists
if ! test -d ${bitcodesDir} ; then
  echo "ERROR: ${bitcodesDir} not found. Run make bitcode." ;
  exit 1 ;
fi

# Get bitcode benchmark dir
benchmarksDir="${PWD_PATH}/benchmarks" ;
mkdir -p ${benchmarksDir} ;

# Copy bitcode for every benchmark
for i in `find ${bitcodesDir} -name all.bc` ; do
  echo "Copying $i" ;
  benchmarkDir="`dirname $i`" ;
  benchmarkName="`basename $benchmarkDir`" ;
  mkdir -p ${benchmarksDir}/${benchmarkName} ;
  cp $i ${benchmarksDir}/${benchmarkName}/ ;
done
