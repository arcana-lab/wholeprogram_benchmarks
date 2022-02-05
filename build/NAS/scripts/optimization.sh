#!/bin/bash

function runOptimizations {
  # Check for benchmark dir
  if [ ! -d "${benchmarksDir}/${1}" ]; then
    echo "Warning: Benchmark directory ${1} not found, skipping." ;
    return ;
  fi

  # Go in the benchmark dir
	cd ${benchmarksDir}/${1} ;

  # Copy all makefiles content in benchmarks
	cp ${PWD_PATH}/makefiles/* . ;

  # Run optimization
	echo "Running your optimizations for \"${1}\"" ;
  make BENCHMARK=${1} >> noelle_output.txt 2>&1 ;
  exitOutput=$? ;
  return ;
}

# Get benchmark suite dir
PWD_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/.." ;

# Get bitcode benchmark dir
benchmarksDir="${PWD_PATH}/benchmarks" ;
if ! test -d ${benchmarksDir} ; then
  echo "ERROR: ${benchmarksDir} not found. Run make setup." ;
  exit 1 ;
fi

# Run optimizations on all benchmarks
if [ "${1}" == "all" ]; then
	for benchmark in `ls ${benchmarksDir}`; do
		runOptimizations ${benchmark} ;
	done

# Run optimizations for the specified benchmark name
else
	runOptimizations ${1} ;
fi

echo "-----------------------------------------------------------"
echo "DONE"

exit ${exitOutput} ;
