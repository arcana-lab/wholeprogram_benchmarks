#!/bin/bash

# Get benchmark suite dir
PWD_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/.." ;

# Compilers
CC="clang" ;
CXX="clang++" ;
FLAGS="-O3" ;

# Libraries
LIBS="-lm -lstdc++" ;

# Additional libraries for lame benchmmark
LIBS_EXTRA="-L${PWD_PATH}/mibench-master/consumer/lame/lame3.70 -lmp3lame -lncurses" ;

function genBinary {
  # Check if bitcode exists
	if [ ! -f "${benchmarksDir}/${1}/${1}.bc" ]; then
		echo "Warning: Bitcode not found for ${1}, skipping" ;
		return ;
	fi

  # Check if binary already exists, if that's the case remove it
	if [ -f "${benchmarksDir}/${1}/${1}" ]; then
		rm ${benchmarksDir}/${1}/${1} ;
	fi

  # Generate binary
	echo "Generating binary '${1}' for ${1} from ${1}.bc" ;
	cd ${benchmarksDir}/${1} ;
  if [ "${1}" == "lame" ] ; then
    ${CXX} ${FLAGS} ${1}.bc ${LIBS} ${LIBS_EXTRA} -o ${1} ;
  else
	  ${CXX} -O3 ${1}.bc ${LIBS} -o ${1} ;
  fi

  # If something goes wrong, return and go to the next benchmark
  if [ "$?" != 0 ] ; then
    echo "ERROR: compiling ${1} from bitcode." ;
    return ;
  fi

	chmod +x ${1} ;
}

# Get bitcode benchmark dir
benchmarksDir="${PWD_PATH}/benchmarks" ;
if ! test -d ${benchmarksDir} ; then
  echo "ERROR: ${benchmarksDir} not found. Run make setup." ;
  exit 1 ;
fi

if [ "${1}" == "all" ]; then
	for benchmark in `ls ${benchmarksDir}`; do
		genBinary ${benchmark} ;
	done
else
	genBinary ${1} ;
fi

echo "-----------------------------------------------------------"

echo "DONE" 
exit
