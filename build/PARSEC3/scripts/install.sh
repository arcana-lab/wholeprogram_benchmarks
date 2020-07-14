#!/bin/bash -e

# Get benchmark suite dir
PWD_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/.." ;
benchmarkSuiteName="parsec-3.0" ;

# Check if we need to extract the benchmark suite
pathToTar="${1}" ;
if ! test -d ${PWD_PATH}/${benchmarkSuiteName} ; then
  tar xf ${pathToTar} -C ${PWD_PATH} ;
fi

# Copy patches
cp -r ${PWD_PATH}/patches/${benchmarkSuiteName} ${PWD_PATH} ;
