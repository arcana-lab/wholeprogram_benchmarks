#!/bin/bash

function runOptimizations {
  # Check for benchmark dir
  if [ ! -d "${benchmarksDir}/${1}" ]; then
    echo "Warning: Benchmark directory ${1} not found, skipping." ;
    return ;
  fi

  # Run optimization
	echo "Running your optimizations for \"${1}\"" ;
	cd ${benchmarksDir}/${1} ;
	cp ${PWD_PATH}/makefiles/* . ;
	make clean > /dev/null ;
  timeout 30m make BENCHMARK=${1} >> noelle_output.txt 2>&1 ;

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

exit
