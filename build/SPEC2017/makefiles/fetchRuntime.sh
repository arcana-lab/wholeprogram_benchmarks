#!/bin/bash

noelleBin="`which noelle`";
noelleDir=`dirname $noelleBin`/../../ ;
noelleDir=`realpath $noelleDir` ;
echo $noelleDir ;
ln -s ${noelleDir}/src/runtime/Parallelizer_utils.cpp
