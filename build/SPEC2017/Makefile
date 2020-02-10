SPECTAR=/project/benchmarks/SPEC2017.tar.gz

all: SPEC2017

SPEC2017: $(SPECTAR)
	tar -xf $^
	chmod +x -R * #@Simone pls help
	./setup.sh

compile:
	./$@.sh 

bitcode:
	./$@.sh

clean:
	rm -rf SPEC2017

.PHONY: clean compile bitcode
