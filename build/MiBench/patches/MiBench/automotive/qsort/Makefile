CC=gcc
SB_OPT=-O1 -Xclang -disable-llvm-passes

FILE1 = qsort_small.c
FILE2 = qsort_large.c

all: qsort

qsort: qsort_large.c Makefile
	$(CC) -static qsort_large.c -o qsort -lm $(SB_OPT)

clean:
	rm -rf qsort_small qsort_large output*
