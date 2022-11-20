#!/bin/bash

function runBenchmark {

  # Get function args
  benchmarkArg="${1}" ;

  # Check if paths exists
  pathToBenchmark="${benchmarksDir}/${benchmarkArg}" ;
  if ! test -d ${pathToBenchmark} ; then
    echo "ERROR: ${pathToBenchmark} not found. Skipping..." ;
    exit 1 ;
  fi

  # Go in the benchmark dir
  cd ${pathToBenchmark} ;

  # Run benchmark in benchmarks/${benchmark}/run dir
  perfStatFile="${pathToBenchmark}/${benchmarkArg}__output.txt" ;
  commandToRunSplit="./${benchmarkArg}" ;
  echo "Running: ${commandToRunSplit} in ${PWD}" ;
  eval perf stat -e instructions:u ${commandToRunSplit} > ${perfStatFile} ;
  eval /usr/bin/time -p ${commandToRunSplit} 2>&1 > ${perfStatFile} ;
  if [ "$?" != 0 ] ; then
    echo "ERROR: run of ${commandToRunSplit} failed." ;
    exit 1 ;
  fi

  # Print last line of perf stat output file
  echo `tail -n 2 ${perfStatFile}` ;
	echo "--------------------------------------------------------------------------------------" ;

  return ;
}

# Get benchmark suite dir
PWD_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/.." ;

# Get args
benchmarkToRun="${1}" ;

# Get benchmark dir
benchmarksDir="${PWD_PATH}/benchmarks" ;
if ! test -d ${benchmarksDir} ; then
  echo "ERROR: ${benchmarksDir} not found. Run make bitcode_copy." ;
  exit 1 ;
fi

# Run benchmark
if [ "${benchmarkToRun}" == "all" ]; then
	for benchmark in `ls ${benchmarksDir}`; do
    runBenchmark ${benchmark} ;
	done
else
  runBenchmark ${benchmarkToRun} ;
fi

echo "DONE" 
exit
