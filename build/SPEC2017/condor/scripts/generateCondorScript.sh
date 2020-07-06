#!/bin/bash

condorFile=$1 ;
origDir=`pwd` ;

# Instantiate the condor script
python2 scripts/generateCondorScript.py scripts/${condorFile} ./${condorFile} "$condorFile" " " ;

# Add the benchmarks
pushd ./ ;
cd ../benchmarks ; 
for i in `ls` ; do
  if ! test -d $i ; then
    continue ;
  fi

  echo "Benchmark = $i" >> ${origDir}/${condorFile} ;
  echo "Queue" >> ${origDir}/${condorFile} ;
done
popd ;
