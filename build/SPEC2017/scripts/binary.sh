#!/bin/bash

# Compilers
CC=clang
CPP=clang++
OPT=opt

# Libraries
LIBS="-lm -mavx -z muldefs -Wno-return-type -lstdc++ "

# Set local variables
if [ "${1}" == "rate" ]; then
	key="_r"
elif [ "${1}" == "speed" ]; then
	key="_s"
else
	key=""
fi
BUILD_DIR=`pwd`

# Check the inputs
if [ ! "${1}" == "rate" ] && [ ! "${1}" == "speed" ]; then
  echo "Please provide version  [rate,speed] for setting up run directories. For Example: ./binary.sh refspeed rate"
  exit
fi

# Check the state
if [ ! -d "${BUILD_DIR}/SPEC2017" ]; then
	echo "Please run ./rebuild.sh first to install SPEC2017 and build benchmarks. Then run ./setupRun.sh to extract bitcodes before running this script."
	exit
fi
if [ ! -d "${BUILD_DIR}/benchmarks" ]; then
	echo "Please run ./setupRun.sh first to build benchmarks and extract bitcodes."
	exit
fi

# Generate Binaries from Bitcode
BENCHMARKS_DIR=${BUILD_DIR}/benchmarks

for benchmark_string in `sed 1d ${BUILD_DIR}/patches/pure_c_cpp_${1}.bset | grep ${key}`; do
	benchmark="$( echo $benchmark_string | awk -F'.' '{print $2}')"
	if [ -f "${BENCHMARKS_DIR}/${benchmark}/${benchmark}_newbin" ]; then
		rm ${BENCHMARKS_DIR}/${benchmark}/${benchmark}_newbin
	fi
	cd ${BENCHMARKS_DIR}/${benchmark}
	echo "Generating binary '${benchmark}_newbin' for ${benchmark} from ${benchmark}.bc" ;
	${CC} -O3 ${benchmark}.bc ${LIBS} -o ${benchmark}_newbin;
	chmod +x ${benchmark}_newbin;
done
echo "-----------------------------------------------------------"

echo "DONE" 
exit
