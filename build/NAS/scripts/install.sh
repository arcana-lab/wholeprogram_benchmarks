#!/bin/bash

# Get benchmark suite dir
PWD_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/.." ;
benchmarkSuiteName="NAS" ;

# Check if we need to extract the benchmark suite
pathToTar="${1}" ;
if ! test -d ${PWD_PATH}/${benchmarkSuiteName} ; then
  tar xf ${pathToTar} -C ${PWD_PATH} ;

  if test -d ${PWD_PATH}/NPB3.0-omp-C ; then 
    mv ${PWD_PATH}/NPB3.0-omp-C ${PWD_PATH}/${benchmarkSuiteName} ;
  fi

  if test -d ${PWD_PATH}/benchmark-subsetting-NPB3.0-omp-C-5d565d9 ; then
    mv ${PWD_PATH}/benchmark-subsetting-NPB3.0-omp-C-5d565d9 ${PWD_PATH}/${benchmarkSuiteName} ;
  fi
fi

# Copy patches
cp -r ${PWD_PATH}/patches/${benchmarkSuiteName} ${PWD_PATH} ;
cp -r ${PWD_PATH}/configs/* ${PWD_PATH}/${benchmarkSuiteName}/config/
mkdir ${PWD_PATH}/${benchmarkSuiteName}/bin
