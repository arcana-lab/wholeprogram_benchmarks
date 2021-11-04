#!/bin/sh

fileInput="input_verylarge.asc";
if ! test -f $fileInput ; then
  tar -d ${fileInput}.xz ;
fi

./bf_e e input_verylarge.asc output_verylarge.enc 1234567890abcdeffedcba0987654321
