#!/bin/sh

fileInput="input_verylarge.enc";
if ! test -f $fileInput ; then
  wget --no-check-certificate http://users.cs.northwestern.edu/~simonec/files/Software/MiBench/${fileInput}.xz ;
  tar -d ${fileInput}.xz ;
fi

./bf_d d $fileInput output_verylarge.asc 1234567890abcdeffedcba0987654321
