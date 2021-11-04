#!/bin/sh

./unpack_input.sh "input_verylarge.enc";

./bf_d d input_verylarge.enc output_verylarge.asc 1234567890abcdeffedcba0987654321
