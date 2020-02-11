SPECTAR=/project/benchmarks/SPEC2017.tar.gz
INPUT=test #test, train, refspeed

all: SPEC2017

SPEC2017: $(SPECTAR)
	tar -xf $^
	chmod +x -R $@/bin $@/tools $@/*.sh
	./scripts/setup.sh

compile_speed:
	./scripts/compile.sh pure_c_cpp_speed

compile_rate:
	./scripts/$@.sh pure_c_cpp_rate

bitcode:
	./scripts/$@.sh $(INPUT)

binary:
	./scripts/$@.sh $(INPUT)

clean:
	rm -rf SPEC2017 benchmarks

.PHONY: clean compile bitcode binary
