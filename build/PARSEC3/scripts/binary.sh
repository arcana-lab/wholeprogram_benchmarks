#!/bin/bash

# Code stolen from parsecmgmt
case "${OSTYPE}" in
  *linux*)   ostype="linux";;
  *solaris*) ostype="solaris";;
  *bsd*)     ostype="bsd";;
  *aix*)     ostype="aix";;
  *hpux*)    ostype="hpux";;
  *irix*)    ostype="irix";;
  *amigaos*) ostype="amigaos";;
  *beos*)    ostype="beos";;
  *bsdi*)    ostype="bsdi";;
  *cygwin*)  ostype="windows";;
  *darwin*)  ostype="darwin";;
  *interix*) ostype="interix";;
  *os2*)     ostype="os2";;
  *osf*)     ostype="osf";;
  *sunos*)   ostype="sunos";;
  *sysv*)    ostype="sysv";;
  *sco*)     ostype="sco";;
  *)         ostype="${OSTYPE}";;
esac
case "${HOSTTYPE}" in
  *i386*)    hosttype="i386";;
  *x86_64*)  hosttype="amd64";;
  *amd64*)   hosttype="amd64";;
  *i486*)    hosttype="amd64";;
  *sparc*)   hosttype="sparc";;
  *sun*)     hosttype="sparc";;
  *ia64*)    hosttype="ia64";;
  *itanium*) hosttype="ia64";;
  *powerpc*) hosttype="powerpc";;
  *ppc*)     hosttype="powerpc";;
  *alpha*)   hosttype="alpha";;
  *mips*)    hosttype="mips";;
  *arm*)     hosttype="arm";;
  *)         hosttype="${HOSTTYPE}";;
esac
host_os_type="${hosttype}-${ostype}" ;

# Get benchmark suite dir
PWD_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/.." ;
benchmarkSuiteName="parsec-3.0" ;

# Compilers
CC="clang" ;
CXX="clang++" ;
FLAGS="-O1" ;

# Libraries
LIBS="-lm -lstdc++ -lpthread" ;

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
  if [ "${1}" == "x264" ] ; then
	  ${CXX} ${FLAGS} ${1}.bc ${LIBS} -L${PWD_PATH}/parsec-3.0/pkgs/apps/x264/inst/${host_os_type}.gclang/lib -lx264 -L/usr/lib64 -L/usr/lib -o ${1} ;
  else
	  ${CXX} ${FLAGS} ${1}.bc ${LIBS} -o ${1} ;
  fi
  cp ${1} ${1}_newbin

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
