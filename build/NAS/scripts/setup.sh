#!/bin/bash
cp ./configs/make.def ./NAS/config/make.def
cp ./configs/suite.def ./NAS/config/suite.def
BUILD_DIR=`pwd`
cd ${BUILD_DIR}

if [ -d "${BUILD_DIR}/benchmarks/" ]; then
  rm -rf ${BUILD_DIR}/benchmarks
fi

