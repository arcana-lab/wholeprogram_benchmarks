#!/bin/bash

# Set local variables
BUILD_DIR=`pwd`

# Enable GLLVM
source /project/gllvm/enable

cd NAS
mkdir bin
CC=gclang CXX=gclang++ make suite -j

echo "DONE compiling NAS benchmarks at ${BUILD_DIR}/NAS" 
