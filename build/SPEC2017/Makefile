SPECTAR=/project/benchmarks/SPEC2017.tar.gz
INPUT=ref #test, train, ref
VERSION=rate #speed, rate

all: SPEC2017

SPEC2017: $(SPECTAR)
	tar -xf $^
	chmod +x -R $@/bin $@/tools $@/*.sh
	./scripts/setup.sh

compile_speed:
	./scripts/compile.sh pure_c_cpp_speed

compile_rate:
	./scripts/compile.sh pure_c_cpp_rate

bitcode:
	./scripts/$@.sh $(VERSION)

setuprun:
	./scripts/$@.sh $(INPUT) $(VERSION)
	
setuprun_all:
	./scripts/setuprun.sh test $(VERSION);
	./scripts/setuprun.sh train $(VERSION);
	./scripts/setuprun.sh ref $(VERSION);

binary:
	./scripts/$@.sh $(VERSION)

run:
	./scripts/$@.sh $(INPUT) $(VERSION)

clean:
	rm -rf SPEC2017 benchmarks

.PHONY: clean compile bitcode binary run
