NASTAR=/project/benchmarks/NAS.tgz
BENCH=CG
INPUT=S

all: NAS

NAS: $(NASTAR)
	tar -xf ${NASTAR}
	mv NPB3.0-omp-C $@
	./scripts/setup.sh

compile:
	./scripts/$@.sh

bitcode:
	./scripts/$@.sh

run:
	./scripts/$@.sh $(BENCH) $(INPUT)

clean:
	rm -rf NAS benchmarks

.PHONY: clean compile bitcode run
