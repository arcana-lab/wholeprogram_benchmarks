#!/bin/bash

# Get benchmark suite dir
PWD_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/.." ;
benchmarkSuiteName="MiBench" ;

function split {
  headOrTail="${1}" ;
  stringToSplit="${2}" ;
  IFS=' ' ;
  read -a stringAsArray <<< "${stringToSplit}" ;

  if [ ${headOrTail} == "h" ] ; then
    echo ${stringAsArray[0]} ;
  else
    echo ${stringAsArray[@]:1} ;
  fi

  return ;
}

function genInputBenchmark {
  # Get function args
  benchmarkArg="${1}" ;

  # Check if paths exists
  pathToBenchmark="${benchmarksDir}/${benchmarkArg}" ;
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

  # Go in the benchmark suite where the script is
  cd ${pathToBinary} ;

  # Get arguments of how to run the binary
  runScript="./runme_${benchmarkArg}.sh" ;
  if ! test -f ${runScript} ; then
    echo "WARNING: ${runScript} not found. Going up one dir." ;
    cd ../ ;
    if ! test -f ${runScript} ; then
      echo "WARNING: ${runScript} not found. Skipping..." ;
      return ;
    fi
  fi

  # Unpack the input if necessary
  if test -f ./unpack_input.sh ; then
    ./unpack_input.sh ;
  fi

  # Generate input.txt (needed by noelle autotuner)
  commandToRun=`tail -n 1 ${runScript}` ;
  binary=$(split h "${commandToRun}") ;
  args=$(split t "${commandToRun}") ;
  echo ${args} > autotuner_input.txt ;

  # The current dir has everything we need to run the program, let's copy it into our benchmarks dir
  cp -r ./* ${benchmarksDir}/${benchmarkArg}/ ;

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
    genInputBenchmark ${benchmark} ;
	done
else
  genInputBenchmark ${benchmarkToRun} ;
fi

echo "DONE." ;
