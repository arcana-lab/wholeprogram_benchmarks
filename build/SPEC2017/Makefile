SPECTAR=/project/benchmarks/SPEC2017.tar.gz
INPUT=test #test, train, ref
VERSION=speed #speed, rate

all: SPEC2017

SPEC2017: $(SPECTAR)
	tar -xf $^
	chmod +x -R $@/bin $@/tools $@/*.sh
	./scripts/install.sh

compile_speed:
	./scripts/compile.sh pure_c_cpp_speed

compile_rate:
	./scripts/compile.sh pure_c_cpp_rate

compile_all:
	./scripts/compile.sh pure_c_cpp_rate;
	./scripts/compile.sh pure_c_cpp_speed;

bitcode:
	./scripts/$@.sh $(VERSION)

setup:
	./scripts/$@.sh $(INPUT) $(VERSION)
	
setup_all:
	./scripts/setup.sh test $(VERSION);
	./scripts/setup.sh train $(VERSION);
	./scripts/setup.sh ref $(VERSION);

binary:
	./scripts/$@.sh $(VERSION)

run:
	./scripts/$@.sh $(INPUT) $(VERSION)

clean:
	./scripts/uninstall.sh;
	rm -rf SPEC2017

.PHONY: clean compile bitcode binary run
