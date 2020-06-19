TAR=/project/benchmarks/mibench-master.tar.bz2
BENCHMARK=all

all: compile_all bitcode setup optimization binary run

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
	./scripts/run.sh $(BENCHMARK)

clean:
	./scripts/uninstall.sh

.PHONY: compile_all bitcode setup optimization binary run clean
