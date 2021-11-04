#!/bin/sh

fileInput="input_verylarge.dat"
if ! test -f $fileInput ; then
  xz -d ${fileInput}.xz ;
fi
