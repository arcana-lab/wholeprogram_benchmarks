#!/bin/sh

if ! test -f input_verylarge.dat ; then
  xz -d input_verylarge.dat.xz ;
fi

./qsort input_verylarge.dat > output_large.txt
