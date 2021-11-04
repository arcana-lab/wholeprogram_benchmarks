#!/bin/sh

fileInput="very_large.adpcm";
if ! test -f data/$fileInput ; then
  pushd ./ ;
  mkdir -p data ;
  cd data ;
  wget --no-check-certificate http://users.cs.northwestern.edu/~simonec/files/Software/MiBench/${fileInput}.xz ;
  tar -d ${fileInput}.xz ;
  popd ;
fi

./bin/rawdaudio < data/$fileInput > output_very_large.pcm
