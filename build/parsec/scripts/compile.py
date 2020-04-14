#!/bin/python
import sys
import os

benchmarks = []
allBench = 0
for bench in sys.argv[1:]:
	if bench == "all":
		allBench = 1
		benchmarks = []
		break
	else:
		benchmarks.append(bench)

os.system("mkdir bitcodes")

if "blackscholes" in benchmarks or allBench:
	command = "cd ./parsec-3.0/pkgs/apps/blackscholes/src/;make clean; CC=gclang CXX=gclang++ make; get-bc blackscholes"
	os.system(command)
	command = "cp ./parsec-3.0/pkgs/apps/blackscholes/src/blackscholes.bc ./bitcodes/"
	os.system(command)

#W.I.P.
if "bodytrack" in benchmarks or allBench:
	print "BODYTRACK: NOT DONE YET"
	#command = "cd ./parsec-3.0/pkgs/apps/bodytrack/src/; CC=gclang CXX=gclang++ ./configure; make; get-bc bodytrack"
	#os.system(command)
	#command = "cp ./parsec-3.0/pkgs/apps/bodytrack/src/bodytrack.bc ./bitcodes/"
	#os.system(command)	

#W.I.P.
if "facesim" in benchmarks or allBench:
	print "FACESIM: NOT DONE YET"
#W.I.P.
if "ferret" in benchmarks or allBench:
	print "FERRET: NOT DONE YET"

if "fluidanimate" in benchmarks or allBench:
	command = "cd ./parsec-3.0/pkgs/apps/fluidanimate/src/;make clean; CC=gclang CXX=gclang++ version=pthreads make; get-bc fluidanimate"
	os.system(command)
	command = "cp ./parsec-3.0/pkgs/apps/fluidanimate/src/fluidanimate.bc ./bitcodes/"
	os.system(command)

if "freqmine" in benchmarks or allBench:
	command = "cd ./parsec-3.0/pkgs/apps/freqmine/src/;make clean; CC=gclang CXX=gclang++ make; get-bc freqmine"
	os.system(command)
	command = "cp ./parsec-3.0/pkgs/apps/freqmine/src/freqmine.bc ./bitcodes/"
	os.system(command)

#W.I.P
if "raytrace" in benchmarks or allBench:
	print "RAYTRACE: NOT DONE YET"
	#command = "cd ./parsec-3.0/pkgs/apps/raytrace/src/; CC=gclang CXX=gclang++ PARSECDIR=../../../../ PARSECPLAT=../../../tools/cmake/src/ ./configure; make; get-bc raytrace"
	#os.system(command)
	#command = "cp ./parsec-3.0/pkgs/apps/raytrace/src/raytrace.bc ./bitcodes/"
	#os.system(command)	

if "swaptions" in benchmarks or allBench:
	command = "cd ./parsec-3.0/pkgs/apps/swaptions/src/;make clean; CC=gclang CXX=gclang++ make; get-bc swaptions"
	os.system(command)
	command = "cp ./parsec-3.0/pkgs/apps/swaptions/src/swaptions.bc ./bitcodes/"
	os.system(command)

#WIP
if "vips" in benchmarks or allBench:
	print "VIPS: NOT DONE YET"
	#command = "cd ./parsec-3.0/pkgs/apps/vips/src/; CC=gclang CXX=gclang++ ./configure; make; get-bc vips"
	#os.system(command)
	#command = "cp ./parsec-3.0/pkgs/apps/vips/src/vips.bc ./bitcodes/"
	#os.system(command)	

if "x264" in benchmarks or allBench:
	command = "cd ./parsec-3.0/pkgs/apps/x264/src/; CC=gclang CXX=gclang++ RANLIB=ranlib ./configure; make; make; get-bc x264"
	os.system(command)
	command = "cp ./parsec-3.0/pkgs/apps/x264/src/x264.bc ./bitcodes/"
	os.system(command)	

if "canneal" in benchmarks or allBench:
	command = "cd ./parsec-3.0/pkgs/kernel/canneal/src/;make clean; CC=gclang CXX=gclang++ make; get-bc canneal"
	os.system(command)
	command = "cp ./parsec-3.0/pkgs/kernel/canneal/src/canneal.bc ./bitcodes/"
	os.system(command)

#WIP
if "dedup" in benchmarks or allBench:
	print "DEDUP: NOT DONE YET"
	#command = "cd ./parsec-3.0/pkgs/kernel/dedup/src/;make clean; CC=gclang CXX=gclang++ make; get-bc dedup"
	#os.system(command)
	#command = "cp ./parsec-3.0/pkgs/kernel/dedup/src/dedup.bc ./bitcodes/"
	#os.system(command)

if "streamcluster" in benchmarks or allBench:
	command = "cd ./parsec-3.0/pkgs/kernel/streamcluster/src/;make clean; CC=gclang CXX=gclang++ make; get-bc streamcluster"
	os.system(command)
	command = "cp ./parsec-3.0/pkgs/kernel/streamcluster/src/streamcluster.bc ./bitcodes/"
	os.system(command)
