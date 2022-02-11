#!/bin/bash

# Setup the local variables and environment
BUILD_DIR=`pwd`
pushd ./;
cd ../../install/bin ;
export PATH=`pwd`:$PATH ;
popd ;

# Check if gclang is in PATH
which gclang ;
if [ "$?" != "0" ] ; then
  echo "ERROR: gclang is not in PATH. For Zythos cluster users, execute: export PATH=/project/gllvm/gllvm/bin:$\{PATH\}" ;
  exit 1 ;
fi

# Get benchmark suite dir
PWD_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/.." ;
benchmarkSuiteName="NAS" ;

# Check benchmark suite is extracted
pathToBenchmarkSuite="${PWD_PATH}/${benchmarkSuiteName}" ;
if ! test -d ${pathToBenchmarkSuite} ; then
  echo "ERROR: ${pathToBenchmarkSuite} not found. Run make install." ;
  exit 1 ;
fi

# Error file: contains list of failing benchmarks
errorFile="${PWD_PATH}/error_compiling.txt" ;
rm -f ${errorFile} ;

# Get a list of all the Makefile(s) (assumption: one Makefile per benchmark)
benchmarks="BT CG EP FT IS LU MG SP"
#benchmarks="CG EP FT IS LU MG"


# Go inside the directory of each Makefile of each benchmark and run make
for elem in ${benchmarks} ; do
  echo "Compiling ${makefileDir}" ;
  ${PWD_PATH}/scripts/compile.sh ${pathToBenchmarkSuite} ${elem} ;

  # If something wrong happened compiling a benchmark put it in error.txt and skip to the next one
  if [ $? != 0 ] ; then
    echo "${elem}" >> ${errorFile} ;
    continue ;
  fi
done
