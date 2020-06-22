#!/bin/bash -e

noelleBin="`which noelle-config`";
noelleDir=`dirname $noelleBin`/../../ ;
noelleDir=`realpath $noelleDir` ;
echo $noelleDir ;
ln -s ${noelleDir}/src/runtime/Parallelizer_utils.cpp
