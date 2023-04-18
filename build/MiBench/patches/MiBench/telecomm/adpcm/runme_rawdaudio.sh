#!/bin/sh

./unpack_input.sh "very_large.adpcm";

./rawdaudio < data/very_large.adpcm > output_very_large.pcm
