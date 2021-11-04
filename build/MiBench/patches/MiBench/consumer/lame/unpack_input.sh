#!/bin/sh

fileInput="very_large.wav";
if ! test -f $fileInput ; then
  wget --no-check-certificate http://users.cs.northwestern.edu/~simonec/files/Software/MiBench/${fileInput}.xz ;
  xz -d ${fileInput}.xz ;
fi
