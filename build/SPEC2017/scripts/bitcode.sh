#!/bin/bash

if [ ! "${1}" == "rate" ] && [ ! "${1}" == "speed" ]; then
  echo "Please provide version  [rate,speed] for setting up run directories. For Example: ./bitcode.sh rate "
  exit
fi


source /project/gllvm/enable
BUILD_DIR=`pwd`


if [ ! -d "../../bitcodes/LLVM9.0/SPEC2017" ]; then
  mkdir ../../bitcodes/LLVM9.0/SPEC2017
fi

cd ../../bitcodes/LLVM9.0/SPEC2017
BITCODE_DIR=`pwd` 
cd ${BUILD_DIR}

#delete previously generated bitcodes
rm -rf ${BITCODE_DIR}/*

if [ ! -d "${BUILD_DIR}/benchmarks/" ]; then
  mkdir ${BUILD_DIR}/benchmarks
fi

if [ ! -d "${BUILD_DIR}/SPEC2017" ]; then
	echo "Please run ./setup.sh and ./compile.sh first to install SPEC2017 and build benchmarks."
	exit
fi


#Setup Run directories with runcpu
cd SPEC2017
source shrc
#runcpu --loose --size ${1} --tune peak -a setup --config gclang pure_c_cpp_$2

#Copy Run directories and extract bitcodes
BENCHMARKS_DIR=${BUILD_DIR}/benchmarks


if [ "${1}" == "rate" ]; then
	key="_r"
elif [ "${1}" == "speed" ]; then
	key="_s"
else
	key=""
fi

for benchmark_string in `sed 1d ${BUILD_DIR}/pure_c_cpp_${1}.bset | grep ${key}`; do
	benchmark="$( echo $benchmark_string | awk -F'.' '{print $2}')"
	if [ ! -d "${BENCHMARKS_DIR}/${benchmark}" ]; then
		mkdir ${BENCHMARKS_DIR}/${benchmark}
	fi
	echo ${benchmark}
	go ${benchmark} run
	cp run_peak_test_gclang.0000/${benchmark}_peak.gclang ${BENCHMARKS_DIR}/${benchmark}/${benchmark}
	cd ${BENCHMARKS_DIR}/${benchmark}
	
	get-bc ${benchmark}
	cp ${benchmark}.bc ${BITCODE_DIR}/

done
echo "-----------------------------------------------------------"
echo "Run directories created at ${BENCHMARKS_DIR} contain respective binaries and bitcodes. Run workload '${1}' with ./run.sh found at respective workload directories."  
 
cd ${BITCODE_DIR}
tar -czf spec2017.tgz *
echo "DONE" 

exit

