#!/bin/bash

function genInputBenchmark {
  # Get function args
  benchmarkArg="${1}" ;

  # Check if paths exists
  pathToBenchmark="${benchmarksDir}/${benchmarkArg}" ;
  if ! test -d ${pathToBenchmark} ; then
    echo "WARNING: ${pathToBenchmark} not found. Skipping..." ;
    return ;
  fi

  # Go in the benchmark suite where the script is
  cd ${pathToBenchmark} ;

  # Create autotuner input file
  touch autotuner_input.txt ;

  return ;
}

# Get benchmark suite dir
PWD_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/.." ;

# Get args
benchmarkToRun="${1}" ;

# Get bitcode benchmark dir
benchmarksDir="${PWD_PATH}/benchmarks" ;
if ! test -d ${benchmarksDir} ; then
  echo "ERROR: ${benchmarksDir} not found. Run make bitcode_copy." ;
  exit 1 ;
fi

# Generate input file that contains the arguments to run the benchmark later
if [ "${benchmarkToRun}" == "all" ]; then
	for benchmark in `ls ${benchmarksDir}`; do
    genInputBenchmark ${benchmark} ;
	done
else
  genInputBenchmark ${benchmarkToRun} ;
fi

echo "DONE." ;
