#!/bin/bash

# Get args
benchmarkToRun="${1}" ;
binaryName="${2}" ;
inputArg="$3" ;

cd train ; 
./../${binaryName} `tail -n 1 ../run_train.sh | awk -F$(BENCHMARK) '{print $$2}'`; 
