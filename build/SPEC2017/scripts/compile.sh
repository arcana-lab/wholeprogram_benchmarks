#!/bin/bash

BUILD_DIR=`pwd`
cd ${BUILD_DIR}

cd SPEC2017
source shrc
runcpu --loose -D --size test --tune peak -a setup --config gclang pure_c_cpp_speed
echo "DONE installing SPEC2017 at ${BUILD_DIR}/SPEC2017" 
