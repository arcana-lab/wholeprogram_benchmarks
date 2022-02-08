#!/bin/bash -e

noelleBin="`which noelle-config`";
noelleDir=`dirname $noelleBin`/../../ ;
noelleDir=`realpath $noelleDir` ;
if test -e Parallelizer_utils.cpp ; then
  exit 0;
fi

echo $noelleDir ;
ln -s ${noelleDir}/src/core/runtime/Parallelizer_utils.cpp
