TAR=/project/benchmarks/NAS.tgz
BENCHMARK=all

all: baseline_code_generation

optimized_code_generation: compile_all bitcode bitcode_copy setup optimization binary run

baseline_code_generation: compile_all bitcode bitcode_copy setup binary

NAS:
	./scripts/install.sh $(TAR)

compile_all: NAS
	./scripts/compile_all.sh

bitcode: NAS
	./scripts/bitcode.sh

bitcode_copy: NAS
	./scripts/bitcode_copy.sh

setup: NAS
	./scripts/setup.sh $(BENCHMARK)

optimization: NAS
	./scripts/optimization.sh $(BENCHMARK)

binary: NAS
	./scripts/binary.sh $(BENCHMARK)
	
run: NAS
	./scripts/run.sh $(BENCHMARK)

clean:
	./condor/scripts/clean.sh
	rm -f *.txt 
	cd condor ; make clean ;
	rm -f tmp* ;

uninstall: clean
	./scripts/uninstall.sh

.PHONY: optimized_code_generation baseline_code_generation compile_all bitcode bitcode_copy setup optimization binary run clean uninstall
