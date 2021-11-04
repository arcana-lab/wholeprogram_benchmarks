#!/bin/sh

fileInput="very_large.pcm";
if ! test -f data/$fileInput ; then
  pushd ./ ;
  mkdir -p data ;
  cd data ;
  wget --no-check-certificate http://users.cs.northwestern.edu/~simonec/files/Software/MiBench/${fileInput}.xz ;
  xz -d ${fileInput}.xz ;
  popd ;
fi

fileInput="very_large.adpcm";
if ! test -f data/$fileInput ; then
  pushd ./ ;
  mkdir -p data ;
  cd data ;
  wget --no-check-certificate http://users.cs.northwestern.edu/~simonec/files/Software/MiBench/${fileInput}.xz ;
  xz -d ${fileInput}.xz ;
  popd ;
fi
