CC=gcc

FILE1 = qsort_small.c
FILE2 = qsort_large.c

all: qsort

qsort: qsort_large.c Makefile
	$(CC) -static qsort_large.c -O3 -o qsort -lm

clean:
	rm -rf qsort_small qsort_large output*
