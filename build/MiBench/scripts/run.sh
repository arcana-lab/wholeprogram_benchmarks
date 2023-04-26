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

  currBinary="${pathToBenchmark}/${benchmarkArg}" ;
  if ! test -f ${currBinary} ; then
    echo "WARNING: ${currBinary} not found. Skipping..." ;
    return ;
  fi

  # Go in the benchmark suite where the script is
  cd ${pathToBinary} ;

  # Copy binary into benchmark suite (i.e., current directory)
  cp ${currBinary} . ;

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

  # The current dir has everything we need to run the program, let's copy it into our benchmarks dir
  cp -r ./* ${pathToBenchmark}/ ;

  # Go in the benchmark dir
  cd ${pathToBenchmark} ;

  # Get arguments of how to run the binary
  runScript="./runme_${benchmarkArg}.sh" ;
  if ! test -f ${runScript} ; then
    echo "ERROR: ${runScript} not found. Abort." ;
    return ;
  fi

  # Run the benchmark
  commandToRun=`tail -n 1 ${runScript}` ;
  binary=$(split h "${commandToRun}") ;
  args=$(split t "${commandToRun}") ;

  perfStatFile="${pathToBenchmark}/${benchmarkArg}_large_output.txt" ;
  commandToRunSplit="${binary} ${args}" ;
  echo "Running: ${commandToRunSplit} in ${pathToBenchmark}" ;
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
