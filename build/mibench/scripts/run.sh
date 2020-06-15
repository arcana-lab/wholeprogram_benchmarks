#!/bin/bash

function runBenchmark {
  # Get function args
  inputArg="${1}" ;
  benchmarkArg="${2}" ;

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

  currBinary="${pathToBenchmark}/${benchmarkArg}" ;
  if ! test -f ${currBinary} ; then
    echo "WARNING: ${currBinary} not found. Skipping..." ;
    return ;
  fi

  # Copy binary into benchmark suite
  cp ${currBinary} ${pathToBinary} ;
  echo "Executing ${pathToBinary}/${benchmarkArg} with ${inputArg} input" ;

  # Go in the benchmark suite and run the binary
  pushd . &> /dev/null ;
  cd ${pathToBinary} ;

  runScript="./runme_${inputArg}.sh" ;
  if ! test -f ${runScript} ; then
    echo "WARNING: ${runScript} not found. Going up one dir." ;
    cd ../ ;
    if ! test -f ${runScript} ; then
      echo "WARNING: ${runScript} not found. Skipping..." ;
      popd  &> /dev/null;
      return ;
    fi
  fi

  ${runScript} ;
  popd &> /dev/null ;
}

# Get benchmark suite dir
PWD_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/.." ;

# Get args
inputToRun="${1}" ;
benchmarkToRun="${2}" ;

# Get bitcode benchmark dir
benchmarksDir="${PWD_PATH}/benchmarks" ;
if ! test -d ${benchmarksDir} ; then
  echo "ERROR: ${benchmarksDir} not found. Run make setup." ;
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
