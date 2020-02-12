#!/bin/bash

BUILD_DIR=`pwd`
cd ${BUILD_DIR}

if [ -d "${BUILD_DIR}/benchmarks/" ]; then
  rm -rf ${BUILD_DIR}/benchmarks
fi

cd SPEC2017
printf 'yes' | ./uninstall.sh 