SPECTAR=/project/benchmarks/SPEC2017.tar.gz
INPUT=test #test, train, ref
VERSION=rate #speed, rate
BENCHMARK=mcf_s #all, lbm_s, xz_r, ...

all: SPEC2017 compile_rate bitcode setup optimization binary run

SPEC2017: $(SPECTAR)
	tar -xf $^
	chmod +x -R $@/bin $@/tools $@/*.sh
	./scripts/install.sh

compile_speed: SPEC2017
	./scripts/compile.sh pure_c_cpp_speed

compile_rate: SPEC2017
	./scripts/compile.sh pure_c_cpp_rate

compile_all:
	./scripts/compile.sh pure_c_cpp_rate;
	./scripts/compile.sh pure_c_cpp_speed;

bitcode:
	./scripts/bitcode.sh $(VERSION)

setup:
	./scripts/setup.sh test $(VERSION);
	./scripts/setup.sh train $(VERSION);
	./scripts/setup.sh ref $(VERSION);

optimization:
	./scripts/optimization.sh $(BENCHMARK)

binary:
	./scripts/$@.sh $(BENCHMARK)
	
run:
	./scripts/$@.sh $(INPUT) $(BENCHMARK)

clean:
	./scripts/uninstall.sh;
	rm -rf SPEC2017

.PHONY: compile_speed compile_rate compile_all bitcode setup optimization binary run clean
