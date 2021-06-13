TAR=/project/benchmarks/parsec-3.0.tar.gz
BENCHMARK=all
INPUT=test

all: baseline_code_generation

optimized_code_generation: compile_all bitcode bitcode_copy setup optimization binary run

baseline_code_generation: compile_all bitcode bitcode_copy setup binary

PARSEC3:
	./scripts/install.sh $(TAR)

compile_all: PARSEC3
	./scripts/compile_all.sh

bitcode: PARSEC3
	./scripts/bitcode.sh

bitcode_copy: PARSEC3
	./scripts/bitcode_copy.sh

setup: PARSEC3
	./scripts/setup.sh

optimization: PARSEC3
	./scripts/optimization.sh $(BENCHMARK)

binary: PARSEC3
	./scripts/binary.sh $(BENCHMARK)
	
run: PARSEC3
	./scripts/run.sh $(INPUT) $(BENCHMARK)

clean:
	./condor/scripts/clean.sh

uninstall:
	./scripts/uninstall.sh
	rm -f *.txt 
	cd condor ; make clean ;
	rm -f tmp* ;

.PHONY: optimized_code_generation baseline_code_generation compile_all bitcode setup optimization binary run clean uninstall
