TAR=/project/benchmarks/parsec-3.0.tar.gz
BENCHMARK=all
INPUT=test

all: baseline_code_generation

optimized_code_generation: compile_all bitcode bitcode_copy setup optimization binary run

baseline_code_generation: compile_all bitcode bitcode_copy setup binary

parsec-3.0:
	./scripts/install.sh $(TAR)

compile_all: parsec-3.0
	./scripts/compile_all.sh

bitcode: parsec-3.0
	./scripts/bitcode.sh

bitcode_copy: parsec-3.0
	./scripts/bitcode_copy.sh

setup: parsec-3.0
	./scripts/setup.sh $(INPUT) $(BENCHMARK)

optimization: parsec-3.0
	./scripts/optimization.sh $(BENCHMARK)

binary: parsec-3.0
	./scripts/binary.sh $(BENCHMARK)
	
run: parsec-3.0
	./scripts/run.sh $(INPUT) $(BENCHMARK)

clean:
	./condor/scripts/clean.sh
	rm -f *.txt 
	cd condor ; make clean ;
	rm -f tmp* ;

uninstall: clean
	./scripts/uninstall.sh

.PHONY: optimized_code_generation baseline_code_generation compile_all bitcode bitcode_copy setup optimization binary run clean uninstall
