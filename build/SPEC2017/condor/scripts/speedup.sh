#!/bin/bash

benchmarks="namd_r parest_r"
benchmarks="$benchmarks `ls benchmarks | grep _s`" ;
finalOutput="" ;

# Setup
rm -f noelle_speedup.txt ;
touch baseline_times.txt ;
touch noelle_times.txt ;

# Fetch the bitcodes
make bitcode ;

for b in $benchmarks ; do
  echo "Checking $b";

  # Check if the baseline time has already been computed
  baselineTime=`awk -v bench=$b '{
      if ($1 == bench){
        print $2 ;
      }
    }' baseline_times.txt` ;
  if test "$baselineTime" == "" ; then

    # Generate the binary for the baseline
    make binary BENCHMARK=$b ;

    # Run the baseline
    make run BENCHMARK=$b INPUT=train &> baseline_$b.txt ;
    baselineTime=`awk '{
        if (  ($2 == "seconds") &&
              ($3 == "time")    &&
              ($4 == "elapsed") ){
          print $1 ;
        }
      }' baseline_$b.txt `;
    echo "$b $baselineTime" >> baseline_times.txt ;
  fi
  echo "  Baseline: $baselineTime" ;

  # Check if the noelle time has already been computed
  noelleTime=`awk -v bench=$b '{
      if ($1 == bench){
        print $2 ;
      }
    }' noelle_times.txt` ;
  if test "$noelleTime" == "" ; then

    # Parallelize the benchmark
    make optimization BENCHMARK=$b ;
    if test $? -ne 0 ; then
      echo "$b Error during parallelization" >> noelle_speedup.txt ;
      continue ;
    fi

    # Generate the parallel binary
    make binary BENCHMARK=$b ;
    if test $? -ne 0 ; then
      echo "$b Error during binary generation (the parallelization succeded)" >> noelle_speedup.txt ;
      continue ;
    fi

    # Run the parallelized binary
    make run BENCHMARK=$b INPUT=train &> noelle_$b.txt ;
    if test $? -ne 0 ; then
      echo "$b Error during execution of the parallel binary" >> noelle_speedup.txt ;
      continue ;
    fi
    noelleTime=`awk '{
        if (  ($2 == "seconds") &&
              ($3 == "time")    &&
              ($4 == "elapsed") ){
          print $1 ;
        }
      }' noelle_$b.txt `;
    echo "$b $noelleTime" >> noelle_times.txt ;
  fi
  echo "  Parallelized: $noelleTime" ;

  # Compute the speedup
  speedup=`echo "scale=3; $baselineTime / $noelleTime" | bc` ;
  echo "$b $speedup" >> noelle_speedup.txt ;
  echo "  Speedup: $speedup" ;

done
