POLYTAR=/project/benchmarks/polybench-3.1.tar.gz 
BENCHMARK=all

all: baseline_code_generation

optimized_code_generation: compile_all bitcode bitcode_copy optimization binary run

baseline_code_generation: compile_all bitcode bitcode_copy binary

polybench-3.1: $(POLYTAR)
	tar -xf $^

compile_all: polybench-3.1
	./scripts/compile.sh ;

bitcode: polybench-3.1
	./scripts/bitcode.sh ;

bitcode_copy: polybench-3.1
	#./scripts/bitcode_copy.sh

optimization: polybench-3.1
	./scripts/optimization.sh $(BENCHMARK)

binary: polybench-3.1
	./scripts/$@.sh $(BENCHMARK)
	
run: polybench-3.1
	./scripts/$@.sh $(BENCHMARK)

clean:
	./scripts/uninstall.sh;

.PHONY: compile_speed compile_rate compile_all bitcode optimization binary run clean