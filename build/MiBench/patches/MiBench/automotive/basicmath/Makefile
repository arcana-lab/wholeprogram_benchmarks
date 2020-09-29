CC=gcc
SB_OPT=-O0 -Xclang -disable-O0-optnone

FILE1 = basicmath_small.c   rad2deg.c  cubic.c   isqrt.c
FILE2 = basicmath_large.c   rad2deg.c  cubic.c   isqrt.c

all: basicmath

basicmath: ${FILE2} Makefile
	$(CC) -static -O1 ${FILE2} -o basicmath -lm $(SB_OPT)

clean:
	rm -rf basicmath output*
