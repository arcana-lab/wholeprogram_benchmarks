#!/bin/bash

BUILD_DIR=`pwd`
cd ${BUILD_DIR}


if [ -d "${BUILD_DIR}/SPEC2017" ]; then
  rm -rf ${BUILD_DIR}/SPEC2017
fi
if [ -d "${BUILD_DIR}/benchmarks/" ]; then
  rm -rf ${BUILD_DIR}/benchmarks
fi

#extract new SPEC2017 Copy and patch
tar -xf /project/benchmarks/SPEC2017.tar.gz

cd SPEC2017
chmod +x -R * #@Simone pls help
printf 'yes' | ./install.sh  
cp ${BUILD_DIR}/gclang.cfg config/
cp ${BUILD_DIR}/pure_c_cpp_speed.bset benchspec/CPU/
source shrc
runcpu --loose -D --size test --tune peak -a setup --config gclang pure_c_cpp_speed
echo "DONE installing SPEC2017 at ${BUILD_DIR}/SPEC2017" 
exit

