CC=gcc
SB_OPT=-O0 -Xclang -disable-O0-optnone

FILE1 = qsort_small.c
FILE2 = qsort_large.c

all: qsort

qsort: qsort_large.c Makefile
	$(CC) -static qsort_large.c -O1 -o qsort -lm $(SB_OPT)

clean:
	rm -rf qsort_small qsort_large output*
