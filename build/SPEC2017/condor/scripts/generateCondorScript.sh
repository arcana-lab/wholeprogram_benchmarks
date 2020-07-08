#!/bin/bash

# Fetch the inputs
if test $# -lt 1 ; then
  echo "USAGE: `basename $0` CONDOR_FILE FILE_SUFFIX" ;
  exit 1;
fi
condorFile="$1" ;
suffixName="$2" ;
origDir=`pwd` ;

# Instantiate the condor script
python2 scripts/generateCondorScript.py scripts/${condorFile} ./${condorFile} "$condorFile" " " ;

# Add the benchmarks
pushd ./ ;
cd ../benchmarks ; 
for i in `ls` ; do

  # Check if it is a directory
  if ! test -d $i ; then
    continue ;
  fi

  # Check if there is the bitcode
  if ! test -e ${i}/${i}${suffixName} ; then
    continue ;
  fi
  echo "  Benchmark ${i} is added" ;

  # Add the entry to the condor file
  echo "Benchmark = $i" >> ${origDir}/${condorFile} ;
  echo "Queue" >> ${origDir}/${condorFile} ;
done
popd ;
