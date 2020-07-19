#!/bin/bash

function runBenchmark {
  # Get function args
  inputArg="${1}" ;
  benchmarkArg="${2}" ;

  # Check if paths exists
  pathToBenchmark="${benchmarksDir}/${benchmarkArg}" ;
  if ! test -d ${pathToBenchmark} ; then
    echo "WARNING: ${pathToBenchmark} not found. Skipping..." ;
    return ;
  fi

  pathToBenchmarkRunDir="${pathToBenchmark}/run" ;
  if ! test -d ${pathToBenchmarkRunDir} ; then
    echo "WARNING: ${pathToBenchmarkRunDir} not found. Skipping..." ;
    return ;
  fi

  pathToBinaryPath="${pathToBenchmarkRunDir}/path.txt" ;
  if ! test -f ${pathToBinaryPath} ; then
    echo "WARNING: ${pathToBinaryPath} not found. Skipping..." ;
    return ;
  fi

  pathToBinary=`cat ${pathToBinaryPath}` ;
  if ! test -d ${pathToBinary} ; then
    echo "WARNING: ${pathToBinary} not found. Skipping..." ;
    return ;
  fi

  currBinary="${pathToBenchmark}/${benchmarkArg}" ;
  if ! test -f ${currBinary} ; then
    echo "WARNING: ${currBinary} not found. Skipping..." ;
    return ;
  fi

  pathToInputConf="${pathToBinary}/../../../parsec/${inputArg}.runconf" ;
  if ! test -f ${pathToInputConf} ; then
    echo "WARNING: ${pathToInputConf} not found. Skipping..." ;
    return ;
  fi

  # Copy binary into run dir under benchmark
  cp ${currBinary} ${pathToBenchmarkRunDir} ;

  # Go in the benchmark dir
  cd ${pathToBenchmarkRunDir} ;

  # Extract inputs in run dir if the input archive exists
  pathToBenchmarkInput="${pathToBinary}/../../../inputs/input_${inputArg}.tar" ;
  if test -f ${pathToBenchmarkInput} ; then
    tar xf ${pathToBenchmarkInput} ;
  fi

  # Get args to run binary with
  NTHREADS=1 source ${pathToInputConf} ;

  # Run benchmark in benchmarks/${benchmark}/run dir
  perfStatFile="${pathToBenchmarkRunDir}/${benchmarkArg}_${inputArg}_output.txt" ;
  commandToRunSplit="./${benchmarkArg} ${run_args}" ;
  echo "Running: ${commandToRunSplit} in ${PWD}" ;
  eval perf stat ${commandToRunSplit} > ${perfStatFile} ;
  if [ "$?" != 0 ] ; then
    echo "ERROR: run of ${commandToRunSplit} failed." ;
    return ;
  fi

  # Print last line of perf stat output file
  echo `tail -n 1 ${perfStatFile}` ;
	echo "--------------------------------------------------------------------------------------" ;

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
    runBenchmark ${inputToRun} ${benchmark} ;
	done
else
  runBenchmark ${inputToRun} ${benchmarkToRun} ;
fi

echo "DONE" 
exit
