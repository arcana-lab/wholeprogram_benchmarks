#!/bin/sh

fileInput="input_very_large.ppm";
if ! test -f $fileInput ; then
  wget --no-check-certificate http://users.cs.northwestern.edu/~simonec/files/Software/MiBench/${fileInput}.xz ;
  tar -d ${fileInput}.xz ;
fi

./jpeg-6a/cjpeg -dct int -progressive -opt -outfile output_very_large_encode.jpeg $fileInput ;
