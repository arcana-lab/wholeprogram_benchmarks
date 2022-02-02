#!/bin/bash

function isNoBenchmark {
  local benchmarkToCopare ;
  benchmarkToCopare="${1}" ;

  local noBenchmarksList ;
  noBenchmarksList=("setparams") ;

  local result ;
  result=0 ;

  for elem in ${noBenchmarksList[@]} ; do
    if [[ "${elem}" == "${benchmarkToCopare}" ]] ; then
      result=1 ;
      break ;
    fi
  done

  echo "${result}" ;
}

# Setup the local variables and environment
BUILD_DIR=`pwd`
pushd ./;
cd ../../install/bin ;
export PATH=`pwd`:$PATH ;
popd ;

# Get benchmark suite dir
PWD_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/.." ;
benchmarkSuiteName="NAS" ;

# Check benchmark suite is extracted
pathToBenchmarkSuite="${PWD_PATH}/${benchmarkSuiteName}" ;
if ! test -d ${pathToBenchmarkSuite} ; then
  echo "ERROR: ${pathToBenchmarkSuite} not found. Run make install." ;
  exit 1 ;
fi

# Get bitcode dir
llvmVersion=`llvm-config --version` ;
bitcodesDir="${PWD_PATH}/../../bitcodes/LLVM${llvmVersion}/${benchmarkSuiteName}" ;
mkdir -p ${bitcodesDir} ;

# Get a list of all generated binaries, we'll use it to extract bitcode files
listOfBinaries=`find ${pathToBenchmarkSuite} -type f \
    -exec bash -c '[[ "$( file -bi "$1" )" == */x-executable* ]]' bash {} ';' \
    -print` ;

# Error file: contains list of failing benchmarks
errorFile="${PWD_PATH}/error_bitcode_generation.txt" ;
rm -f ${errorFile} ;

for elem in ${listOfBinaries} ; do
  # Check whether the current benchmark we want to extract a bitcode file from is a real benchmark or not, if it is not, then skip to the next one
  currentBenchmark=`basename ${elem}` ;
  isNotABenchmark=$(isNoBenchmark ${currentBenchmark}) ;
  if [ ${isNotABenchmark} == "1" ] ; then
    continue ;
  fi

  echo "Generating bitcode for ${elem}" ;

  # Extract bitcode file
  get-bc ${elem} ;

  # The command get-bc returns 0 even if the binary was not generated with gclang, so we check whether the extracted bitcode exists or not
  if ! test -f ${elem}.bc ; then
    echo "${elem}" >> ${errorFile} ;
    continue ;
  fi

  # Create bitcode dir (it will contain the bitcode file and path.txt of where the binary was in the benchmark suite)
  benchmark=`basename ${elem}` ;
  bitcodeDir=${bitcodesDir}/${benchmark} ;
  mkdir -p ${bitcodeDir} ;

  # Copy bitcode
  cp ${elem}.bc ${bitcodeDir} ;

  # Copy path of where the binary is (needed later)
  benchmarkDir=`dirname ${elem}` ;
  echo "${benchmarkDir}" > ${bitcodeDir}/path.txt ;
done
