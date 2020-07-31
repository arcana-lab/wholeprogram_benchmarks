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
  binaryNameArg="${2}" ;

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

  currBinary="${pathToBenchmark}/${binaryNameArg}" ;
  if ! test -f ${currBinary} ; then
    echo "WARNING: ${currBinary} not found. Skipping..." ;
    return ;
  fi

  pushd . ;

  # Copy binary into benchmark suite
  cp ${binaryNameArg} ${pathToBinary} ;

  # Go in the benchmark suite and run the binary
  cd ${pathToBinary} ;

  # Get arguments of how to run the binary
  runScript="./runme_${benchmarkArg}.sh" ;
  if ! test -f ${runScript} ; then
    echo "WARNING: ${runScript} not found. Going up one dir." ;
    cd ../ ;
    if ! test -f ${runScript} ; then
      echo "WARNING: ${runScript} not found. Skipping..." ;
      popd ;
      return ;
    fi
  fi
  commandToRun=`tail -n 1 ${runScript}` ;
  args=$(split t "${commandToRun}") ;

  # Run the binary
  commandToRunSplit="./${binaryNameArg} ${args}" ;
  echo "Running: ${commandToRunSplit} in ${PWD}" ;
  eval ${commandToRunSplit} ;
  if [ "$?" != 0 ] ; then
    echo "ERROR: run of ${commandToRunSplit} failed." ;
    popd ;
    return ;
  fi

  # If everything goes well, copy everything back to benchmark dir
  cp -r ${pathToBinary}/* ${pathToBenchmark} ;

	echo "--------------------------------------------------------------------------------------" ;

  popd ;
  return ;
}

# Get benchmark suite dir
PWD_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/../.." ;

# Get args
benchmarkToRun="${1}" ;
binaryName="${2}" ;


# Run benchmark
runBenchmark ${benchmarkToRun} ${binaryName} ;

echo "DONE" 
exit
