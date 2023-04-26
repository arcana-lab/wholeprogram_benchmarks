TAR=/project/benchmarks/mibench-master.tar.bz2
BENCHMARK=all
INPUT=large # useless, we always use large for MiBench, necessary to match SPEC2017 Makefile

all: baseline_code_generation

optimized_code_generation: compile_all bitcode bitcode_copy setup optimization binary run

baseline_code_generation: compile_all bitcode bitcode_copy setup binary

MiBench:
	./scripts/install.sh $(TAR)

compile_all: MiBench
	./scripts/compile_all.sh

bitcode: MiBench
	./scripts/bitcode.sh

bitcode_copy: MiBench
	./scripts/bitcode_copy.sh

setup: MiBench
	./scripts/setup.sh $(BENCHMARK)

optimization: MiBench
	./scripts/optimization.sh $(BENCHMARK)

binary: MiBench
	./scripts/binary.sh $(BENCHMARK)
	
run: MiBench
	./scripts/run.sh $(INPUT) $(BENCHMARK)

clean:
	./condor/scripts/clean.sh
	rm -f *.txt 
	cd condor ; make clean ;
	rm -f tmp* ;

uninstall: clean
	./scripts/uninstall.sh

.PHONY: optimized_code_generation baseline_code_generation compile_all bitcode bitcode_copy setup optimization binary run clean uninstall
