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

  # Go in the benchmark suite where the script is
  cd ${pathToBinary} ;

  # Get arguments of how to run the binary
#  runScript="./runme_${benchmarkArg}.sh" ;
#  if ! test -f ${runScript} ; then
#    echo "WARNING: ${runScript} not found. Going up one dir." ;
#    cd ../ ;
#    if ! test -f ${runScript} ; then
#      echo "WARNING: ${runScript} not found. Skipping..." ;
#      return ;
#    fi
#  fi

  # Unpack the input if necessary
#  if test -f ./unpack_input.sh ; then
#    ./unpack_input.sh ;
#  fi

  # Set the stack size to be unlimited. This is needed for IS
  ulimit -s unlimited  ;

  # Run the benchmark
#  commandToRun=`tail -n 1 ${runScript}` ;
  binary=./${benchmarkArg} ; #$(split h "${commandToRun}") ;

  # Copy binary into benchmark suite (i.e., current directory)
  echo "Executing ${pathToBinary}/${benchmarkArg}" ;
  cp ${currBinary} . ;

  perfStatFile="${PWD_PATH}/benchmarks/${benchmarkArg}/${benchmarkArg}_large_output.txt" ;
  commandToRunSplit="${binary}" ;
  echo "Running: ${commandToRunSplit} in ${PWD}" ;
  eval perf stat -e instructions:u ${commandToRunSplit} > ${perfStatFile} ;
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
