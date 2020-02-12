#!/bin/bash

# Set local variables
BUILD_DIR=`pwd`

# Check the inputs
if [ ! "${1}" == "test" ] && [ ! "${1}" == "train" ] && [ ! "${1}" == "ref" ]; then
 
	echo "Please provide input configuration [test,train,refspeed] for setting up run directories. For Example: ./binary.sh ref rate -run"
	exit
fi
if [ ! "${2}" == "rate" ] && [ ! "${2}" == "speed" ]; then
  echo "Please provide version  [rate,speed] for setting up run directories. For Example: ./binary.sh ref rate -run"
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

if [ "${1}" == "ref" ] && [ "${2}" == "rate" ]; then
	inputsize="refrate"
elif [ "${1}" == "ref" ] && [ "${2}" == "speed" ]; then
	inputsize="refspeed"
else
	inputsize=${1}
fi


# Set local variables
if [ "${2}" == "rate" ]; then
	key="_r"
elif [ "${2}" == "speed" ]; then
	key="_s"
else
	key=""
fi

# Run generated binaries with specified workloads
echo "Running $2 benchmarks with workload: ${inputsize}"
for benchmark_string in `sed 1d ${BUILD_DIR}/patches/pure_c_cpp_${2}.bset | grep ${key}`; do
benchmark="$( echo $benchmark_string | awk -F'.' '{print $2}')"
	cd ${BENCHMARKS_DIR}/${benchmark}/${inputsize}
	lastline="`tail -n 1 speccmds.cmd`"
	arguments="$( echo $lastline | awk -F'peak.gclang ' '{print $2}')"
	echo "Running ${benchmark} with ${benchmark}_newbin ${arguments} >${benchmark}_${inputsize}_output.txt"
	${BENCHMARKS_DIR}/${benchmark}/${benchmark}_newbin ${arguments} >${BENCHMARKS_DIR}/${benchmark}/${benchmark}_${inputsize}_output.txt
	echo "-----------------------------------------------------------"
done

echo "DONE" 
exit
