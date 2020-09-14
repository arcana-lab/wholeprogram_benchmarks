#!/bin/bash -e

noelleBin="`which noelle-config`";
noelleDir=`dirname $noelleBin`/../../ ;
noelleDir=`realpath $noelleDir` ;
echo $noelleDir ;
ln -s ${noelleDir}/src/core/runtime/Parallelizer_utils.cpp
