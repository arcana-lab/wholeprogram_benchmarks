# Commands
CC=clang
CPP=clang++
OPT=opt
OPT_LEVEL=-O3

# Arguments
BENCHMARK=
PARALLELIZATION_OPTIONS=-noelle-verbose=1 -noelle-pdg-verbose=1 -noelle-min-hot=5 -noelle-disable-helix -noelle-disable-dswp -noelle-disable-doall

# Front-end
FRONTEND_FLAGS=-emit-llvm -O0 -Xclang -disable-O0-optnone
INCLUDES=-Iinclude/threadpool/include

# Runtime
RUNTIME_DIRNAME="threadpool"
RUNTIME_GITREPO="https://github.com/scampanoni/virgil.git"
RUNTIME_CFLAGS="-DDEBUG"
RUNTIME=Parallelizer_utils

# Libraries
LIBS=-lm -lstdc++ -lpthread

all: baseline_parallelized.bc

baseline_parallelized.bc: baseline_with_metadata.bc
	noelle-parallelizer $^ -o $@ $(PARALLELIZATION_OPTIONS)
	llvm-dis $@
	cp $@ $(BENCHMARK).bc

baseline_with_metadata.bc: output.prof baseline.bc
	noelle-meta-prof-embed $^ -o $@
	noelle-meta-pdg-embed $@ -o $@
	llvm-dis $@

output.prof: default.profraw
	llvm-profdata merge $^ -output=$@

default.profraw: baseline_prof
	cd test ; ./../$< `tail -n 1 ../run_train.sh | awk -F$(BENCHMARK) '{print $$2}'`; mv $@ ../ ;

baseline_prof: baseline.bc
	noelle-prof-coverage $^ $@ $(LIBS)

baseline.bc: $(BENCHMARK).bc $(RUNTIME).bc
	llvm-link $^ -o $@
	noelle-pre $@
	llvm-dis $@

$(RUNTIME).bc: $(RUNTIME).cpp download
	$(CPP) $(RUNTIME_CFLAGS) $(INCLUDES) -std=c++14 -emit-llvm $(OPT_LEVEL) -c $< -o $@

$(RUNTIME).cpp:
	./fetchRuntime.sh

download:
	mkdir -p include ; cd include ; ../download.sh $(RUNTIME_GITREPO) $(RUNTIME_DIRNAME) ;

clean:
	rm -rf include/ Parallelizer_utils.* baseline* default.profraw output.prof *.txt *.dot
