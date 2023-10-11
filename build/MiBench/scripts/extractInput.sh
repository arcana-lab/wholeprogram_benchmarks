#!/bin/bash

# Get benchmark suite dir
PWD_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/.." ;

# Get args
benchmarkToRun="`basename ${PWD}`" ;
echo "MiBench: extracting input for ${benchmarkToRun}" ;

# Re-execute setup to extract input and generate autotuner_input.txt
${PWD_PATH}/scripts/setup.sh ${benchmarkToRun} ;

echo "DONE" ;
exit ;
