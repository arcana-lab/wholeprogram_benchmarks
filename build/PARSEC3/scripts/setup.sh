#!/bin/bash

function genInputBenchmark {
  # Get function args
  inputArg="${1}" ;
  benchmarkArg="${2}" ;

  # Check if paths exists
  pathToBenchmark="${benchmarksDir}/${benchmarkArg}" ;
  if ! test -d ${pathToBenchmark} ; then
    echo "ERROR: ${pathToBenchmark} not found. Skipping..." ;
    exit 1 ;
  fi

  pathToBinaryPath="${pathToBenchmark}/path.txt" ;
  if ! test -f ${pathToBinaryPath} ; then
    echo "ERROR: ${pathToBinaryPath} not found. Skipping..." ;
    exit 1 ;
  fi

  pathToBinary=`cat ${pathToBinaryPath}` ;
  if ! test -d ${pathToBinary} ; then
    echo "ERROR: ${pathToBinary} not found. Skipping..." ;
    exit 1 ;
  fi

  pathToInputConf="${pathToBinary}/../../../parsec/${inputArg}.runconf" ;
  if ! test -f ${pathToInputConf} ; then
    echo "ERROR: ${pathToInputConf} not found. Skipping..." ;
    exit 1 ;
  fi

  # Go in the benchmark dir
  cd ${pathToBenchmark} ;

  # Extract inputs in run dir if the input archive exists
  pathToBenchmarkInput="${pathToBinary}/../../../inputs/input_${inputArg}.tar" ;
  if test -f ${pathToBenchmarkInput} ; then
    tar xf ${pathToBenchmarkInput} ;
  fi

  # Get args to run binary with
  NTHREADS=1 source ${pathToInputConf} ;

  echo ${run_args} > autotuner_input.txt ;

  return ;
}

# Get benchmark suite dir
PWD_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/.." ;

# Get args
inputToRun="${1}" ;
benchmarkToRun="${2}" ;

# Get benchmark dir
benchmarksDir="${PWD_PATH}/benchmarks" ;
if ! test -d ${benchmarksDir} ; then
  echo "ERROR: ${benchmarksDir} not found. Run make bitcode_copy." ;
  exit 1 ;
fi

# Run benchmark
if [ "${benchmarkToRun}" == "all" ]; then
	for benchmark in `ls ${benchmarksDir}`; do
    genInputBenchmark ${inputToRun} ${benchmark} ;
	done
else
  genInputBenchmark ${inputToRun} ${benchmarkToRun} ;
fi

echo "DONE" 
exit
