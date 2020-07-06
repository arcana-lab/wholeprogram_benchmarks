#!/bin/bash

# Fetch the input
if test $# -lt 1 ; then
  echo "USAGE: `basename $0` BENCHMARK" ;
  exit 1;
fi
b="$1" ;

# Clean
rm -f benchmarks/${b}/default.profraw ;
rm -f benchmarks/${b}/baseline* ;
rm -f benchmarks/${b}/noelle_output.txt ;
rm -f benchmarks/${b}/*train_output.txt ;

echo "Optimizing $b" ;

# Parallelize the benchmark
make optimization BENCHMARK=$b ;
if test $? -ne 0 ; then
  echo "$b Error during parallelization" >> noelle_speedup.txt ;
  continue ;
fi

# Generate the parallel binary
make binary BENCHMARK=$b ;
if test $? -ne 0 ; then
  echo "$b Error during binary generation (the parallelization succeded)" >> noelle_speedup.txt ;
  continue ;
fi
