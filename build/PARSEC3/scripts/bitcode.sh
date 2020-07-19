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

function isNoBenchmark {
  local benchmarkToCopare ;
  benchmarkToCopare="${1}" ;

  local noBenchmarksList ;
  noBenchmarksList=() ;

  local result ;
  result=0 ;

  for elem in ${noBenchmarksList[@]} ; do
    if [[ "${elem}" == "${benchmarkToCopare}" ]] ; then
      result=1 ;
      break ;
    fi
  done

  echo "${result}" ;
}

# Setup the local variables and environment
BUILD_DIR=`pwd`
pushd ./;
cd ../../install/bin ;
export PATH=`pwd`:$PATH ;
popd ;

# Get benchmark suite dir
PWD_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/.." ;
benchmarkSuiteName="parsec-3.0" ;

# Check benchmark suite is extracted
pathToBenchmarkSuite="${PWD_PATH}/${benchmarkSuiteName}" ;
if ! test -d ${pathToBenchmarkSuite} ; then
  echo "ERROR: ${pathToBenchmarkSuite} not found. Run make install." ;
  exit 1 ;
fi

# Get bitcode dir
llvmVersion=`llvm-config --version` ;
bitcodesDir="${PWD_PATH}/../../bitcodes/LLVM${llvmVersion}/${benchmarkSuiteName}" ;
mkdir -p ${bitcodesDir} ;

# Error file: contains list of failing benchmarks
errorFile="${PWD_PATH}/error_bitcode_generation.txt" ;
rm -f ${errorFile} ;

for apps_kernels in `ls ${pathToBenchmarkSuite}/pkgs` ; do
  if [[ ${apps_kernels} != "apps" && ${apps_kernels} != "kernels" ]] ; then
    continue ;
  fi

  for benchmark in `ls ${pathToBenchmarkSuite}/pkgs/${apps_kernels}` ; do
    pathToBenchmarkBinary=${pathToBenchmarkSuite}/pkgs/${apps_kernels}/${benchmark}/inst/${host_os_type}.gclang/bin/${benchmark} ;

    # Extract bitcode
    get-bc ${pathToBenchmarkBinary} ;

    # The command get-bc returns 0 even if the binary was not generated with gclang, so we check whether the extracted bitcode exists or not
    if ! test -f ${pathToBenchmarkBinary}.bc ; then
      echo "${pathToBenchmarkBinary}" >> ${errorFile} ;
      continue ;
    fi

    # Create bitcode dir (it will contain the bitcode file and path.txt of where the binary was in the benchmark suite)
    bitcodeDir=${bitcodesDir}/${benchmark} ;
    mkdir -p ${bitcodeDir} ;

    # Copy bitcode
    cp ${pathToBenchmarkBinary}.bc ${bitcodeDir} ;

    # Copy path of where the binary is (needed later)
    benchmarkDir=`dirname ${pathToBenchmarkBinary}` ;
    echo "${benchmarkDir}" > ${bitcodeDir}/path.txt ;
  done
done
