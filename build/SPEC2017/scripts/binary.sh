#!/bin/bash
CC=clang
CPP=clang++
OPT=opt
# Libraries
LIBS="-lm -mavx -z muldefs -Wno-return-type -lstdc++ "

if [ ! "${1}" == "test" ] && [ ! "${1}" == "train" ] && [ ! "${1}" == "refspeed" ]; then
 
	echo "Please provide input configuration [test,train,refspeed] for setting up run directories. For Example: ./binary.sh refspeed rate -run"
	exit
fi


if [ ! "${2}" == "rate" ] && [ ! "${2}" == "speed" ]; then
  echo "Please provide version  [rate,speed] for setting up run directories. For Example: ./binary.sh refspeed rate -run"
  exit
fi

source /project/gllvm/enable
BUILD_DIR=`pwd`

if [ ! -d "${BUILD_DIR}/SPEC2017" ]; then
	echo "Please run ./rebuild.sh first to install SPEC2017 and build benchmarks. Then run ./setupRun.sh to extract bitcodes before running this script."
	exit
fi


if [ ! -d "${BUILD_DIR}/benchmarks" ]; then
	echo "Please run ./setupRun.sh first to build benchmarks and extract bitcodes."
	exit
fi


if [ "${2}" == "rate" ]; then
	key="_r"
elif [ "${2}" == "speed" ]; then
	key="_s"
else
	key=""
fi
#Generate Binaries from Bitcode
BENCHMARKS_DIR=${BUILD_DIR}/benchmarks

for benchmark_string in `grep ${key} ${BUILD_DIR}/pure_c_cpp_${2}.bset`; do
	benchmark="$( echo $benchmark_string | awk -F'.' '{print $2}')"
	if [ ! -d "${BENCHMARKS_DIR}/${benchmark}/$1" ]; then
		echo "Please run ./setupRun.sh $1 first to setup run directories for $1."
		exit
	fi
	if [ -f "${BENCHMARKS_DIR}/${benchmark}/${benchmark}_newbin" ]; then
		rm ${BENCHMARKS_DIR}/${benchmark}/${benchmark}_newbin
	fi
	cd ${BENCHMARKS_DIR}/${benchmark}
	echo "Generating binary '${benchmark}_newbin' for ${benchmark} from ${benchmark}.bc" ;
	${CC} -O3 ${benchmark}.bc ${LIBS} -o ${benchmark}_newbin;
	chmod +x ${benchmark}_newbin;
done
echo "-----------------------------------------------------------"


#Run generated binaries with specified workloads
if [ "${3}" == "-run" ]; then
	echo "Running $2 benchmarks with workload: $1"
	for benchmark_string in `grep ${key} ${BUILD_DIR}/pure_c_cpp_${2}.bset`; do
	benchmark="$( echo $benchmark_string | awk -F'.' '{print $2}')"
		cd ${BENCHMARKS_DIR}/${benchmark}/$1
		lastline="`tail -n 1 speccmds.cmd`"
		arguments="$( echo $lastline | awk -F'peak.gclang ' '{print $2}')"
		echo "Running ${benchmark} with ${benchmark}_newbin ${arguments} >${benchmark}_${1}_output.txt"
		${BENCHMARKS_DIR}/${benchmark}/${benchmark}_newbin ${arguments} >${BENCHMARKS_DIR}/${benchmark}/${benchmark}_${1}_output.txt
		echo "-----------------------------------------------------------"
	done
fi
	
echo "DONE" 
exit

