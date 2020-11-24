#!/bin/bash

PWD_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/.." ;

BUILD_DIR=`pwd`
cd ${BUILD_DIR}

if [ -d "${BUILD_DIR}/benchmarks/" ]; then
  rm -rf ${BUILD_DIR}/benchmarks
fi

cd SPEC2017
printf 'yes' | ./install.sh  
cp ${BUILD_DIR}/patches/gclang.cfg config/
cp ${BUILD_DIR}/patches/pure_c_cpp_speed.bset benchspec/CPU/
cp ${BUILD_DIR}/patches/pure_c_cpp_rate.bset benchspec/CPU/
tar xf ${BUILD_DIR}/patches/parest_r_patch.tar.xz

cp -r ${PWD_PATH}/patches/SPEC2017 ${PWD_PATH} ;
