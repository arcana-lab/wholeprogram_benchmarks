#!/bin/sh

fileInput="very_large.pcm";
if ! test -f data/$fileInput ; then
  pushd ./ ;
  mkdir -p data ;
  cd data ;
  wget --no-check-certificate http://users.cs.northwestern.edu/~simonec/files/Software/MiBench/${fileInput}.xz ;
  tar -d ${fileInput}.xz ;
  popd ;
fi

./bin/rawcaudio < data/$fileInput > output_very_large.adpcm
