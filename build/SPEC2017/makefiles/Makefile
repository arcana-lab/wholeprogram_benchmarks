# Commands
CC=clang
CPP=clang++
OPT=opt
OPT_LEVEL=-O3

# Arguments
BENCHMARK=
PARALLELIZATION_OPTIONS=-noelle-verbose=3 -dswp-force -noelle-disable-helix -dswp-no-scc-merge

# Front-end
FRONTEND_FLAGS=-emit-llvm -O0 -Xclang -disable-O0-optnone
INCLUDES=-Iinclude/threadpool/include

# Runtime
RUNTIME_DIRNAME="threadpool"
RUNTIME_GITREPO="https://github.com/scampanoni/virgil.git"
RUNTIME_CFLAGS="-DDEBUG"
THREADER=Parallelizer_utils

# Libraries
LIBS=-lm -lstdc++ -lpthread

all: baseline_parallelized.bc

baseline_parallelized.bc: baseline_with_metadata.bc
	noelle-load -parallelization -heuristics -parallelizer $(PARALLELIZATION_OPTIONS) $< -o $@
	llvm-dis $@
	cp $@ $(BENCHMARK).bc

baseline_with_metadata.bc: baseline_hotprofiled.bc
	noelle-meta-pdg-embed $< -o $@
	llvm-dis $@

baseline_hotprofiled.bc: output.prof baseline.bc
	noelle-load -pgo-test-profile-file=$< -block-freq -pgo-instr-use -HotProfiler $(word 2,$^) -o $@
	llvm-dis $@

output.prof: default.profraw
	llvm-profdata merge $^ -output=$@

default.profraw: baseline_prof
	cd test ; ./../$< `tail -n 1 ../run_test.sh | awk -F$(BENCHMARK) '{print $$2}'`; mv $@ ../ ;

baseline_prof: baseline_prof.bc
	$(CPP) -fprofile-instr-generate $^ $(LIBS) -o $@

baseline_prof.bc: baseline.bc
	./inject_hotprofiler.sh $^ $@

baseline.bc: $(BENCHMARK).bc $(THREADER).bc
	llvm-link $^ -o $@
	noelle-norm $@ -o $@
	llvm-dis $@

$(THREADER).bc: $(THREADER).cpp download
	$(CPP) $(RUNTIME_CFLAGS) $(INCLUDES) -std=c++14 -emit-llvm $(OPT_LEVEL) -c $< -o $@

$(THREADER).cpp:
	ln -s ${NOELLE_DIR}/../src/runtime/Parallelizer_utils.cpp

download:
	mkdir -p include ; cd include ; ../download.sh $(RUNTIME_GITREPO) $(RUNTIME_DIRNAME) ;

clean:
	rm -rf include/ Parallelizer_utils.* baseline* default.profraw output.prof *.txt *.dot
