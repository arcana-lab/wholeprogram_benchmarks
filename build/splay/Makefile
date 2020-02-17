all: libsplay-tree.a run-splay

MALLOCER=${CARAT_HOME}/kernel/malloc_logger/malloc_logger.c

libsplay-tree.a: splay-tree.o
	ar ruv libsplay-tree.a splay-tree.o

splay-tree.o: splay-tree.c splay-tree.h
	clang -Wall -O2 -c splay-tree.c

run-splay: run-splay.c splay-tree.h
	clang -Wall -O2 run-splay.c -L. -lsplay-tree -o run-splay

malloced: run-splay.c splay-tree.h ${MALLOCER} 
	clang -fPIC -Wall -O2 -c splay-tree.c
	ar ruv libsplay-tree.a splay-tree.o
	clang -Wall -O2 run-splay.c -L. -lsplay-tree -fPIC -shared  ${MALLOCER} -ldl -o run-splay

clean:
	rm -f splay-tree.o libsplay-tree.a run-splay



