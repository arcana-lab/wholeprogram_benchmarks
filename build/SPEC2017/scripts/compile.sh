#!/bin/bash

# Set local variables
BUILD_DIR=`pwd`

# Enable GLLVM
source /project/gllvm/enable

if [ ! -d "${BUILD_DIR}/SPEC2017" ]; then
	echo "Error: Please run \"./scripts/install.sh\"  first to install SPEC2017."
	exit
fi
cd SPEC2017
source shrc
runcpu -D --loose --size test --tune peak -a setup --config gclang $1
echo "DONE installing SPEC2017 at \"${BUILD_DIR}/SPEC2017\"" 
