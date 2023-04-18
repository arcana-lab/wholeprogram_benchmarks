#!/bin/sh

./unpack_input.sh "very_large.pcm";

./rawcaudio < data/very_large.pcm > output_very_large.adpcm
