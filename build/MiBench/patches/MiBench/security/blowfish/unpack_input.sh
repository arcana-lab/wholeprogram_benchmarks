#!/bin/sh

fileInput="input_verylarge.enc";
if ! test -f $fileInput ; then
  if ! test -f ${fileInput}.xz ; then
    wget --no-check-certificate http://users.cs.northwestern.edu/~simonec/files/Software/MiBench/${fileInput}.xz ;
  fi
  xz -d ${fileInput}.xz ;
fi

fileInput="input_verylarge.asc";
if ! test -f $fileInput ; then
  xz -d ${fileInput}.xz ;
fi
