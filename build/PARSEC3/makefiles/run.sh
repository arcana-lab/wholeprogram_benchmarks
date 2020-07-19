#!/bin/bash

function runBenchmark {
  # Get function args
  benchmarkArg="${1}" ;
  binaryNameArg="${2}" ;

  inputArg="simlarge" ;

  # Check if paths exists
  pathToBenchmark="${PWD_PATH}/benchmarks/${benchmarkArg}" ;
  if ! test -d ${pathToBenchmark} ; then
    echo "WARNING: ${pathToBenchmark} not found. Skipping..." ;
    return ;
  fi

  pathToBinaryPath="${pathToBenchmark}/path.txt" ;
  if ! test -f ${pathToBinaryPath} ; then
    echo "WARNING: ${pathToBinaryPath} not found. Skipping..." ;
    return ;
  fi

  pathToBinary=`cat ${pathToBinaryPath}` ;
  if ! test -d ${pathToBinary} ; then
    echo "WARNING: ${pathToBinary} not found. Skipping..." ;
    return ;
  fi

  currBinary="${pathToBenchmark}/${binaryNameArg}" ;
  if ! test -f ${currBinary} ; then
    echo "WARNING: ${currBinary} not found. Skipping..." ;
    return ;
  fi

  pathToInputConf="${pathToBinary}/../../../parsec/${inputArg}.runconf" ;
  if ! test -f ${pathToInputConf} ; then
    echo "WARNING: ${pathToInputConf} not found. Skipping..." ;
    return ;
  fi

  # Create run dir
  rm -rf ${pathToBenchmark}/run ;
  mkdir ${pathToBenchmark}/run ;

  # Copy binary into run dir under benchmark
  cp ${binaryNameArg} ${pathToBenchmark}/run ;

  # Go in the benchmark run dir
  cd ${pathToBenchmark}/run ;

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
    return ;
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
