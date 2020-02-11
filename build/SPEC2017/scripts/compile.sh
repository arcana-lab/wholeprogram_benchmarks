#!/bin/bash

# Set local variables
BUILD_DIR=`pwd`

# Enable GLLVM
source /project/gllvm/enable

cd SPEC2017
source shrc
runcpu --loose -D --size test --tune peak -a setup --config gclang $1
echo "DONE installing SPEC2017 at ${BUILD_DIR}/SPEC2017" 
