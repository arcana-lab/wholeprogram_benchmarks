#!/bin/sh

fileInput="very_large.wav";
if ! test -f $fileInput ; then
  wget --no-check-certificate http://users.cs.northwestern.edu/~simonec/files/Software/MiBench/${fileInput}.xz ;
  tar -d ${fileInput}.xz ;
fi

./lame3.70/lame ${fileInput} output_very_large.mp3
