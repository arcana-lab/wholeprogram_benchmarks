#!/bin/bash

# Check if gclang is in PATH
which gclang ;
if [ "$?" != "0" ] ; then
  echo "ERROR: gclang is not in PATH. For Zythos cluster users, execute: export PATH=/project/gllvm/gllvm/bin:$\{PATH\}" ;
  exit 1 ;
fi

# Get benchmark suite dir
PWD_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/.." ;
benchmarkSuiteName="MiBench" ;

# Check benchmark suite is extracted
pathToBenchmarkSuite="${PWD_PATH}/${benchmarkSuiteName}" ;
if ! test -d ${pathToBenchmarkSuite} ; then
  echo "ERROR: ${pathToBenchmarkSuite} not found. Run make install." ;
  exit 1 ;
fi

# Error file: contains list of failing benchmarks
errorFile="${PWD_PATH}/error_compiling.txt" ;
rm -f ${errorFile} ;

# Get a list of all the Makefile(s) (assumption: one Makefile per benchmark)
listOfMakefile=`find ${pathToBenchmarkSuite} -name "Makefile"` ;

# Go inside the directory of each Makefile of each benchmark and run make
for elem in ${listOfMakefile} ; do
  makefileDir=`dirname ${elem}` ;
  echo "Compiling ${makefileDir}" ;
  ${PWD_PATH}/scripts/compile.sh ${makefileDir} ;

  # If something wrong happened compiling a benchmark put it in error.txt and skip to the next one
  if [ $? != 0 ] ; then
    echo "${makefileDir}" >> ${errorFile} ;
    continue ;
  fi
done
