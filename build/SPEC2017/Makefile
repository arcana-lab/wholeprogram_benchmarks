SPECTAR=/project/benchmarks/SPEC2017.tar.gz

all: SPEC2017

SPEC2017: $(SPECTAR)
	tar -xf $^
	chmod +x -R $@/bin $@/tools
	./scripts/setup.sh

compile:
	./scripts/$@.sh 

bitcode:
	./scripts/$@.sh

clean:
	rm -rf SPEC2017

.PHONY: clean compile bitcode
