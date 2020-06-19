#!/bin/bash

# Get benchmark suite dir
PWD_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/.." ;
benchmarkSuiteName="MiBench" ;

errorFiles="${PWD_PATH}/error_*.txt" ;
rm -f ${errorFiles} ;

benchmarksDir="${PWD_PATH}/benchmarks" ;
rm -rf ${benchmarksDir} ;

llvmVersion=`llvm-config --version` ;
bitcodesDir="${PWD_PATH}/../../bitcodes/LLVM${llvmVersion}/${benchmarkSuiteName}" ;
rm -rf ${bitcodesDir} ;

benchmarkSuiteDir="${PWD_PATH}/${benchmarkSuiteName}" ;
rm -rf ${benchmarkSuiteDir} ;
