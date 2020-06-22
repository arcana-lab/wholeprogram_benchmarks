TAR=/project/benchmarks/mibench-master.tar.bz2
BENCHMARK=all
INPUT=large # useless, we always use large for MiBench, necessary to match SPEC2017 Makefile

all: baseline_code_generation

optimized_code_generation: compile_all bitcode setup optimization binary run

baseline_code_generation: compile_all bitcode setup binary

MiBench: $(TAR)
	./scripts/install.sh $(TAR)

compile_all: MiBench
	./scripts/compile_all.sh

bitcode: MiBench
	./scripts/bitcode.sh

setup: MiBench
	./scripts/setup.sh

optimization: MiBench
	./scripts/optimization.sh $(BENCHMARK)

binary: MiBench
	./scripts/binary.sh $(BENCHMARK)
	
run: MiBench
	./scripts/run.sh $(INPUT) $(BENCHMARK)

clean:
	./scripts/uninstall.sh

.PHONY: optimized_code_generation baseline_code_generation compile_all bitcode setup optimization binary run clean
