#!/bin/bash

benchmarks="`ls benchmarks`" ;
finalOutput="" ;

# Setup
numRuns="5" ;
rm -f noelle_speedup.txt ;
touch baseline_times.txt ;
touch noelle_times.txt ;
touch noelle_speedup.txt ;

# Fetch the bitcodes
make bitcode ;

# Clean
rm -f benchmarks/*/default.profraw ;
rm -f benchmarks/*/baseline* ;
rm -f benchmarks/*/noelle_output.txt ;
rm -f benchmarks/*/*train_output.txt ;

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
    touch baseline_${b}.txt ;
    for i in `seq 1 $numRuns` ; do

      # Run
      make run BENCHMARK=$b INPUT=train &> baseline_${b}_${i}.txt ;

      # Collect the time
      baselineTime=`awk '{
          if (  ($2 == "seconds") &&
                ($3 == "time")    &&
                ($4 == "elapsed") ){
            print $1 ;
          }
        }' baseline_${b}_${i}.txt `;

      # Append the time
      echo "$baselineTime" >> baseline_${b}.txt ;
    done

    # Fetch the median
    baselineTime=`awk -v n=$numRuns '
      BEGIN {
        l = 0;
        target = n/2 ;
      } {
        if (l >= target){
          print ;
          exit ;
        }
        l++ ;
      }' baseline_${b}.txt` ;
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
    hasFailed="0" ;
    touch noelle_${b}.txt ;
    for i in `seq 1 $numRuns` ; do

      # Run
      make run BENCHMARK=$b INPUT=train &> noelle_${b}_${i}.txt ;
      if test $? -ne 0 ; then
        echo "$b Error during execution of the parallel binary" >> noelle_speedup.txt ;
        hasFailed="1" ;
        break ;
      fi

      # Collect the time
      noelleTime=`awk '{
          if (  ($2 == "seconds") &&
                ($3 == "time")    &&
                ($4 == "elapsed") ){
            print $1 ;
          }
        }' noelle_${b}_${i}.txt `;

      # Append the time
      echo "$noelleTime" >> noelle_${b}.txt ;
    done
    if test "$hasFailed" == "1" ; then
      continue ;
    fi

    # Fetch the median
    noelleTime=`awk -v n=$numRuns '
      BEGIN {
        l = 0;
        target = n/2 ;
      } {
        if (l >= target){
          print ;
          exit ;
        }
        l++ ;
      }' noelle_${b}.txt` ;
    echo "$b $noelleTime" >> noelle_times.txt ;
  fi
  echo "  Parallelized: $noelleTime" ;

  # Compute the speedup
  speedup=`echo "scale=3; $baselineTime / $noelleTime" | bc` ;
  echo "$b $speedup" >> noelle_speedup.txt ;
  echo "  Speedup: $speedup" ;

done
