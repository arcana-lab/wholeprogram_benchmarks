CC=gcc

FILE1 = basicmath_small.c   rad2deg.c  cubic.c   isqrt.c
FILE2 = basicmath_large.c   rad2deg.c  cubic.c   isqrt.c

all: basicmath

basicmath: ${FILE2} Makefile
	$(CC) -static -O3 ${FILE2} -o basicmath -lm

clean:
	rm -rf basicmath output*
