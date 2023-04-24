#!/bin/sh

./unpack_input.sh "input_very_large.ppm";

./cjpeg -dct int -progressive -opt -outfile output_very_large_encode.jpeg input_very_large.ppm ;
