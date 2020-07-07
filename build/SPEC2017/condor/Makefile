EMAIL=

all: optimize.con run

run: 
	./scripts/submit.sh *.con

speedup.con:
	python2 scripts/generateCondorScript.py scripts/$@ ./$@ "$@" " " ${EMAIL};

optimize.con:
	./scripts/generateCondorScript.sh $@

binary.con:
	./scripts/generateCondorScript.sh $@

run.con:
	./scripts/generateCondorScript.sh $@

clean:
	rm -rf log/*.out log/*.err log/*.log *~ ./*.con

.PHONY: all run clean
