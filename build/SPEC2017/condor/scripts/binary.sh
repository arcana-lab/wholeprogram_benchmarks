#!/bin/bash

# Fetch the input
if test $# -lt 1 ; then
  echo "USAGE: `basename $0` BENCHMARK" ;
  exit 1;
fi
b="$1" ;
echo "Generating the binary for $b" ;

# Clean
rm -f benchmarks/${b}/noelle_optimize.txt ;

# Generate the parallel binary
make binary BENCHMARK=$b ;
if test $? -ne 0 ; then
  echo "$b Error during binary generation" >> noelle_optimize.txt ;
  exit 1;
fi

exit 0;
