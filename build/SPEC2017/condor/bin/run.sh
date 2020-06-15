#!/bin/bash

# Fetch the inputs
if test $# -lt 1 ; then
  echo "USAGE: `basename $0` REPO_DIR " ;
  exit 1;
fi
repoDir="$1" ;

# Setup the environment
source ~/.bash_profile ;

# Go to the working directory
cd $repoDir/ ;

# Run
./condor/scripts/speedup.sh ;
