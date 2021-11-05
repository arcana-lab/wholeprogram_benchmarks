POLYTAR=/project/benchmarks/polybench-3.1.tar.gz 
BENCHMARK=all

all: baseline_code_generation

optimized_code_generation: compile_all bitcode bitcode_copy optimization binary run

baseline_code_generation: compile_all bitcode bitcode_copy binary

polybench-3.1: $(POLYTAR)
	if ! test -d polybench-3.1 ; then tar -xf $^ ; fi

compile_all: polybench-3.1
	./scripts/compile.sh ;

bitcode: polybench-3.1
	./scripts/bitcode.sh ;

bitcode_copy:
	./scripts/bitcode_copy.sh

optimization: polybench-3.1
	./scripts/optimization.sh $(BENCHMARK)

binary: polybench-3.1
	./scripts/$@.sh $(BENCHMARK)
	
run: polybench-3.1
	./scripts/$@.sh $(BENCHMARK)

clean:
	rm -f *.txt 
	cd condor ; make clean ;
	rm -f tmp* ;

uninstall: clean
	./scripts/uninstall.sh

.PHONY: compile_speed compile_rate compile_all bitcode optimization binary run clean
