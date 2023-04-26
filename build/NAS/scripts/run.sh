#!/bin/bash

function runBenchmark {
  # Get function args
  benchmarkArg="${1}" ;

  # Check if paths exists
  pathToBenchmark="${benchmarksDir}/${benchmarkArg}" ;
  if ! test -d ${pathToBenchmark} ; then
    echo "WARNING: ${pathToBenchmark} not found. Skipping..." ;
    return ;
  fi

  # Go back in the benchmark dir
  cd ${pathToBenchmark} ;

  # Set the stack size to be unlimited. This is needed for IS
  ulimit -s unlimited  ;

  # Run the benchmark
  binary="./${benchmarkArg}" ;

  # Copy binary into benchmark suite (i.e., current directory)
  echo "Executing ${benchmarkArg}" ;

  perfStatFile="${pathToBenchmark}/${benchmarkArg}_large_output.txt" ;
  commandToRunSplit="${binary}" ;
  echo "Running: ${commandToRunSplit} in ${pathToBenchmark}" ;
  # eval perf stat ${commandToRunSplit} > ${perfStatFile} ;
  eval /usr/bin/time -p ${commandToRunSplit} 2>&1 > ${perfStatFile} ;
  if [ "$?" != 0 ] ; then
    echo "ERROR: run of ${commandToRunSplit} failed." ;
    return ;
  fi

  # Print last line of perf stat output file
  cat ${perfStatFile} ;
	echo "--------------------------------------------------------------------------------------" ;

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
