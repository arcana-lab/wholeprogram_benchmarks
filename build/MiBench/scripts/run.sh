#!/bin/bash

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

function runBenchmark {
  # Get function args
  benchmarkArg="${1}" ;

  # Go in the benchmark dir
  cd ${benchmarksDir}/${benchmarkArg} ;

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

  # Run the benchmark
  commandToRun=`tail -n 1 ${runScript}` ;
  binary=$(split h "${commandToRun}") ;
  args=$(split t "${commandToRun}") ;

  # Copy binary into benchmark suite (i.e., current directory)
  #echo "Executing ${pathToBinary}/${benchmarkArg}" ;
  #cp ${currBinary} . ;

  perfStatFile="${PWD_PATH}/benchmarks/${benchmarkArg}/${benchmarkArg}_large_output.txt" ;
  commandToRunSplit="${binary} ${args}" ;
  echo "Running: ${commandToRunSplit} in ${PWD}" ;
  # eval perf stat ${commandToRunSplit} > ${perfStatFile} ;
  eval /usr/bin/time -p ${commandToRunSplit} 2>&1 > ${perfStatFile} ;
  if [ "$?" != 0 ] ; then
    echo "ERROR: run of ${commandToRunSplit} failed." ;
    return ;
  fi

  # Print last line of perf stat output file
  echo `tail -n 2 ${perfStatFile}` ;
	echo "--------------------------------------------------------------------------------------" ;

  return ;
}

# Get benchmark suite dir
PWD_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/.." ;

# Get args
inputToIgnore="${1}" ;
benchmarkToRun="${2}" ;

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
