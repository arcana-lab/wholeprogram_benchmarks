#!/bin/bash

# Setup the local variables and environment
BUILD_DIR=`pwd`
pushd ./ &>/dev/null ;
cd ../../install/bin ;
export PATH=`pwd`:$PATH ;
popd &>/dev/null ;

# Check if gclang is in PATH
which gclang ;
if [ "$?" != "0" ] ; then
  echo "ERROR: gclang is not in PATH. For Zythos cluster users, execute: export PATH=/project/gllvm/gllvm/bin:$\{PATH\}" ;
  exit 1 ;
fi

# Get benchmark suite dir
PWD_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/.." ;
benchmarkSuiteName="parsec-3.0" ;

# Check benchmark suite is extracted
pathToBenchmarkSuite="${PWD_PATH}/${benchmarkSuiteName}" ;
if ! test -d ${pathToBenchmarkSuite} ; then
  echo "ERROR: ${pathToBenchmarkSuite} not found. Run make install." ;
  exit 1 ;
fi

# Error file: contains list of failing benchmarks
errorFile="${PWD_PATH}/error_compiling.txt" ;
rm -f ${errorFile} ;

# Go inside benchmark suite dir
cd ${pathToBenchmarkSuite} ;

# Clean up environment
./bin/parsecmgmt -a fulluninstall -c gclang ;
./bin/parsecmgmt -a fullclean -c gclang ;

# Compile list of benchmarks with gclang (cannot compile them all, parsec stops at the first error)
benchmarksList=("blackscholes" "bodytrack" "fluidanimate" "freqmine" "swaptions" "x264" "canneal" "streamcluster") ;
for elem in ${benchmarksList[@]} ; do
  ./bin/parsecmgmt -a build -c gclang -p ${elem} ;
done
