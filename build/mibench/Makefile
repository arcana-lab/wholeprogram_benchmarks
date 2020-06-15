TAR=/project/benchmarks/mibench-master.tar.bz2
BENCHMARK=all
INPUT=small

all: install compile_all bitcode setup optimization binary run

install: $(TAR)
	./scripts/install.sh $(TAR)

compile_all:
	./scripts/compile_all.sh

bitcode:
	./scripts/bitcode.sh

setup:
	./scripts/setup.sh

optimization:
	./scripts/optimization.sh $(BENCHMARK)

binary:
	./scripts/binary.sh $(BENCHMARK)
	
run:
	./scripts/run.sh $(INPUT) $(BENCHMARK)

clean:
	./scripts/uninstall.sh

.PHONY: install compile_all bitcode setup optimization binary run clean
