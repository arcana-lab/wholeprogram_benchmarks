#!/bin/bash
source /project/gllvm/enable
BUILD_DIR=`pwd`

benchmarks=(BT CG EP FT IS LU MG SP)
versions=(A B C S W)

if [ ! -d "../../bitcodes/LLVM9.0/NAS" ]; then
  mkdir ../../bitcodes/LLVM9.0/SPEC2017
fi

cd ../../bitcodes/LLVM9.0/NAS
BITCODE_DIR=`pwd` 
cd ${BUILD_DIR}

#delete previously generated bitcodes
rm -rf ${BITCODE_DIR}/*

if [ ! -d "${BUILD_DIR}/benchmarks/" ]; then
  mkdir ${BUILD_DIR}/benchmarks
else
  rm -rf ${BUILD_DIR}/benchmarks/*
fi

if [ ! -d "${BUILD_DIR}/NAS" ]; then
	echo "Please run ./setup.sh and ./compile.sh first to install NAS and build benchmarks."
	exit
fi


#Setup Run directories with runcpu

BENCHMARKS_DIR=${BUILD_DIR}/benchmarks

cd ${BUILD_DIR}/NAS/bin/
for bench in ${benchmarks[*]}
do
    mkdir ${BENCHMARKS_DIR}/${bench}
    for ver in ${versions[*]}
    do
    	get-bc ./${bench,,}.${ver}
    done
    cp ${BUILD_DIR}/NAS/bin/${bench,,}.* ${BENCHMARKS_DIR}/${bench}/
done




echo "DONE"

exit

