#!/bin/bash

# Get benchmark suite dir
PWD_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/.." ;

# Check if we need to extract the benchmark suite
pathToTar="${1}" ;
if ! test -d ${PWD_PATH}/mibench-master ; then
  tar xf ${pathToTar} -C ${PWD_PATH} ;
fi

# Copy patches
cp -r ${PWD_PATH}/patches/mibench-master ${PWD_PATH} ;
