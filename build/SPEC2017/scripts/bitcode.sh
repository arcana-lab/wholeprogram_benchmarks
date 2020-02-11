#!/bin/bash

if [ ! "${1}" == "test" ] && [ ! "${1}" == "train" ] && [ ! "${1}" == "refspeed" ]; then
  echo "Please provide input configuration [test,train,refspeed] for setting up run directories. For Example: ./bitcode.sh refspeed rate "
  exit
fi


if [ ! "${2}" == "rate" ] && [ ! "${2}" == "speed" ]; then
  echo "Please provide version  [rate,speed] for setting up run directories. For Example: ./bitcode.sh refspeed rate "
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
runcpu --loose --size ${1} --tune peak -a setup --config gclang pure_c_cpp_$2

#Copy Run directories and extract bitcodes
BENCHMARKS_DIR=${BUILD_DIR}/benchmarks


if [ "${2}" == "rate" ]; then
	key="_r"
elif [ "${2}" == "speed" ]; then
	key="_s"
else
	key=""
fi

for benchmark_string in `grep ${key} ${BUILD_DIR}/pure_c_cpp_${2}.bset`; do
	benchmark="$( echo $benchmark_string | awk -F'.' '{print $2}')"
	if [ ! -d "${BENCHMARKS_DIR}/${benchmark}" ]; then
		mkdir ${BENCHMARKS_DIR}/${benchmark}
	fi
	if [ -d "${BENCHMARKS_DIR}/${benchmark}/$1" ]; then
		rm -r ${BENCHMARKS_DIR}/${benchmark}/$1
	fi
	go ${benchmark} run
	cp -r run_peak_${1}_gclang.0000 ${BENCHMARKS_DIR}/${benchmark}/$1
	cd ${BENCHMARKS_DIR}/${benchmark}
	mv $1/${benchmark}_peak.gclang ${BENCHMARKS_DIR}/${benchmark}/${benchmark}
	get-bc ${benchmark}
	cp ${benchmark}.bc ${BITCODE_DIR}/
	
	lastline="`tail -n 1 $1/speccmds.cmd`"
	arguments="$( echo $lastline | awk -F'peak.gclang ' '{print $2}')"
	echo '#!/bin/bash' > run_$1.sh
	echo "cd `pwd`/$1" >> run_$1.sh
	echo "./../${benchmark} ${arguments}" >> run_$1.sh
	chmod +x run_$1.sh
done
echo "-----------------------------------------------------------"
echo "Run directories created at ${BENCHMARKS_DIR} contain respective binaries and bitcodes. Run workload '${1}' with ./run.sh found at respective workload directories."  
 
cd ${BITCODE_DIR}
tar -czf spec2017.tgz *
echo "DONE" 

exit

