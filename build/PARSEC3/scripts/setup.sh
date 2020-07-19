#!/bin/bash

# Get benchmark suite dir
PWD_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/.." ;
benchmarkSuiteName="parsec-3.0" ;

# Get benchmarks dir
benchmarksDir="${PWD_PATH}/benchmarks" ;
if ! test -d ${benchmarksDir} ; then
  echo "ERROR: ${benchmarksDir} not found. Run make bitcode_copy." ;
  exit 1 ;
fi

# Setup run dir for all benchmarks
for benchmark in `ls ${benchmarksDir}`; do
  # Get benchmark dir
  benchmarkDir="${benchmarksDir}/${benchmark}" ;
  if ! test -d ${benchmarkDir} ; then
    echo "ERROR: ${benchmarkDir} not found. Run make bitcode_copy." ;
    exit 1 ;
  fi

  # Check if bc exists
  benchmarkBC="${benchmarkDir}/${benchmark}.bc" ;
  if ! test -f ${benchmarkBC} ; then
    echo "ERROR: ${benchmarkBC} not found. Run make bitocde_copy." ;
    exit 1 ;
  fi

  # Check if path.txt exists
  benchmarkPathTxt="${benchmarkDir}/path.txt" ;
  if ! test -f ${benchmarkPathTxt} ; then
    echo "ERROR: ${benchmarkPathTxt} not found. Run make bitocde_copy." ;
    exit 1 ;
  fi

  # Create run dir
  benchmarkDirRun="${benchmarkDir}/run" ;
  rm -rf ${benchmarkDirRun} ;
  mkdir -p ${benchmarkDirRun} ;

  # Copy necessary files in run dir
  cp ${benchmarkBC} ${benchmarkDirRun} ;
  cp ${benchmarkPathTxt} ${benchmarkDirRun} ;

done

echo "DONE." ;
