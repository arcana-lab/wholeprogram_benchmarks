EMAIL=
CONDOR_FILE=speedup.con

all: run

run: $(CONDOR_FILE)
	./scripts/submit.sh $(CONDOR_FILE)

$(CONDOR_FILE):
	python2 scripts/generateCondorScript.py scripts/$(CONDOR_FILE) ./$@.con "$@" " " ${EMAIL};

optimize.con:
	./scripts/generateCondorScript.sh $@

clean:
	rm -rf log/*.out log/*.err log/*.log *~ ./*.con

.PHONY: run clean
