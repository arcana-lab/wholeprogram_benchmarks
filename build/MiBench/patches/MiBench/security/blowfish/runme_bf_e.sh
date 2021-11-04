#!/bin/sh

./unpack_input.sh "input_verylarge.asc"

./bf_e e input_verylarge.asc output_verylarge.enc 1234567890abcdeffedcba0987654321
