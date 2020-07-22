#!/bin/bash

function runBenchmark {
  # Get function args
  benchmarkArg="${1}" ;
  binaryNameArg="${2}" ;

  inputArg="simlarge" ;

  # Check if paths exists
  pathToBenchmark="${PWD_PATH}/benchmarks/${benchmarkArg}" ;
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

  currBinary="${pathToBenchmark}/${binaryNameArg}" ;
  if ! test -f ${currBinary} ; then
    echo "ERROR: ${currBinary} not found. Skipping..." ;
    exit 1 ;
  fi

  pathToInputConf="${pathToBinary}/../../../parsec/${inputArg}.runconf" ;
  if ! test -f ${pathToInputConf} ; then
    echo "ERROR: ${pathToInputConf} not found. Skipping..." ;
    exit 1 ;
  fi

  # Go in the benchmark run dir
  cd ${pathToBenchmark} ;

  # Copy .bc into run dir (needed by makefiles/Makefile)
  cp ../${benchmarkArg}.bc . ;

  # Extract inputs in run dir if the input archive exists
  pathToBenchmarkInput="${pathToBinary}/../../../inputs/input_${inputArg}.tar" ;
  if test -f ${pathToBenchmarkInput} ; then
    tar xf ${pathToBenchmarkInput} ;
  fi

  # Get args to run binary with
  NTHREADS=1 source ${pathToInputConf} ;

  # Run benchmark in benchmarks/${benchmark}/run dir
  commandToRunSplit="./${binaryNameArg} ${run_args}" ;
  echo "Running: ${commandToRunSplit} in ${PWD}" ;
  eval ${commandToRunSplit} ;
  if [ "$?" != 0 ] ; then
    echo "ERROR: run of ${commandToRunSplit} failed." ;
    exit 1 ;
  fi

	echo "--------------------------------------------------------------------------------------" ;

  return ;
}

# Get benchmark suite dir
PWD_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/../../.." ;

# Get args
benchmarkToRun="${1}" ;
binaryName="${2}" ;

# Run benchmark
runBenchmark ${benchmarkToRun} ${binaryName} ;

echo "DONE" 
exit
