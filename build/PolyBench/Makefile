POLYTAR=/project/benchmarks/polybench-3.1.tar.gz 
BENCHMARK=all

all: baseline_code_generation

optimized_code_generation: compile_all bitcode bitcode_copy optimization binary run

baseline_code_generation: compile_all bitcode bitcode_copy binary

PolyBench: $(POLYTAR)
	tar -xf $^

compile_all: PolyBench
	./scripts/compile.sh ;

bitcode: PolyBench
	./scripts/bitcode.sh ;

bitcode_copy: PolyBench
	./scripts/bitcode_copy.sh

optimization: PolyBench
	./scripts/optimization.sh $(BENCHMARK)

binary: PolyBench
	./scripts/$@.sh $(BENCHMARK)
	
run: PolyBench
	./scripts/$@.sh $(BENCHMARK)

clean:
	./scripts/uninstall.sh;
	rm -rf PolyBench

.PHONY: compile_speed compile_rate compile_all bitcode optimization binary run clean
