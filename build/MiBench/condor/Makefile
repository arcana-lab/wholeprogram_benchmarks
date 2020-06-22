EMAIL=
CONDOR_FILE=speedup.con

all: run

run: $(CONDOR_FILE)
	./scripts/submit.sh $(CONDOR_FILE)

$(CONDOR_FILE):
	python2 scripts/generateCondorScript.py scripts/$(CONDOR_FILE) ./$@.con "$@" "-noelle-verbose=3 -noelle-disable-helix -noelle-disable-dswp -noelle-disable-doall" ${EMAIL};

clean:
	rm -rf log/*.out log/*.err log/*.log *~ ./*.con

.PHONY: run clean
