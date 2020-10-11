#!/bin/bash

# Clean
rm -f benchmarks/*/default.profraw ;
rm -f benchmarks/*/baseline* ;
rm -f benchmarks/*/noelle_output.txt ;
rm -f benchmarks/*/*train_output.txt ;
rm -f benchmarks/*/NOELLE_input.bc ;
rm -f benchmarks/*/*newbin;
rm -f benchmarks/*/*.dot ;
rm -f benchmarks/*/Parallelizer_utils.cpp ;
rm -f *.txt ;

pushd ./ ;
cd benchmarks ;
for i in `ls` ; do
  if ! test -d $i ; then
    continue ;
  fi
  rm -f $i/$i ;
done
popd ;

pushd ./ ;
cd condor ; 
make clean ; 
popd ;
