#!/bin/bash
CC=clang
CPP=clang++
OPT=opt
# Libraries
LIBS="-lm -mavx -z muldefs -Wno-return-type -lstdc++ "

if [ ! "${1}" == "test" ] && [ ! "${1}" == "train" ] && [ ! "${1}" == "refspeed" ]; then
 
	echo "Please provide input configuration [test,train,refspeed] for setting up run directories. For Example: ./genBinaryfromBitcodes.sh refspeed "
	exit
fi

source /project/gllvm/enable
BUILD_DIR=`pwd`

if [ ! -d "${BUILD_DIR}/SPEC2017" ]; then
	echo "Please run ./rebuild.sh first to install SPEC2017 and build benchmarks. Then run ./setupRun.sh to extract bitcodes before running this script."
	exit
fi


if [ ! -d "${BUILD_DIR}/benchmarks" ]; then
	echo "Please run ./setupRun.sh first to build benchmarks and extract bitcodes"
	exit
fi


#Generate Binaries from Bitcode
BENCHMARKS_DIR=${BUILD_DIR}/benchmarks

for benchmark in omnetpp_s xalancbmk_s deepsjeng_s leela_s perlbench_s mcf_s lbm_s x264_s imagick_s nab_s xz_s; do
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
if [ "${2}" == "run" ]; then
	echo "Running benchmarks with workload: $1"
	for benchmark in omnetpp_s xalancbmk_s deepsjeng_s leela_s perlbench_s mcf_s lbm_s x264_s imagick_s nab_s xz_s; do
		cd ${BENCHMARKS_DIR}/${benchmark}/$1
		lastline="`tail -n 1 speccmds.cmd`"
		arguments="$( echo $lastline | awk -F'peak.gclang ' '{print $2}')"
		echo "Running ${benchmark} with ${benchmark}_newbin ${arguments} >${benchmark}_${1}_output.txt"
		${BENCHMARKS_DIR}/${benchmark}/${benchmark}_newbin ${arguments} >${BENCHMARKS_DIR}/${benchmark}/${benchmark}_${1}_output.txt
		echo "-----------------------------------------------------------"
	done
fi
cd ${BUILD_DIR}	
	
echo "DONE" 
exit

