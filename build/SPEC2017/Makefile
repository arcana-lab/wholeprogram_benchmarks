SPECTAR=/project/benchmarks/SPEC2017.tar.gz
INPUT=test #test, train, ref
VERSION=rate #speed, rate
BENCHMARK=mcf_r #all, lbm_s, xz_r, ...

all: baseline_code_generation

optimized_code_generation: compile_all bitcode setup optimization binary run

baseline_code_generation: compile_all bitcode setup binary

SPEC2017: $(SPECTAR)
	tar -xf $^
	chmod +x -R $@/bin $@/tools $@/*.sh
	./scripts/install.sh

compile_speed: SPEC2017
	./scripts/compile.sh pure_c_cpp_speed

compile_rate: SPEC2017
	./scripts/compile.sh pure_c_cpp_rate

compile_all: SPEC2017
	./scripts/compile.sh pure_c_cpp_rate;
	./scripts/compile.sh pure_c_cpp_speed;

bitcode: SPEC2017
	./scripts/bitcode.sh rate
	./scripts/bitcode.sh speed

setup: SPEC2017
	./scripts/setup.sh test rate;
	./scripts/setup.sh train rate;
	./scripts/setup.sh ref rate;
	./scripts/setup.sh test speed;
	./scripts/setup.sh train speed;
	./scripts/setup.sh ref speed;

optimization: SPEC2017
	./scripts/optimization.sh $(BENCHMARK)

binary: SPEC2017
	./scripts/$@.sh $(BENCHMARK)
	
run: SPEC2017
	./scripts/$@.sh $(INPUT) $(BENCHMARK)

clean:
	./scripts/uninstall.sh;
	rm -rf SPEC2017

.PHONY: compile_speed compile_rate compile_all bitcode setup optimization binary run clean
