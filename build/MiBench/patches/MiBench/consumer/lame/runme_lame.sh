#!/bin/sh

./unpack_input.sh "very_large.wav";

./lame3.70/lame very_large.wav output_very_large.mp3
