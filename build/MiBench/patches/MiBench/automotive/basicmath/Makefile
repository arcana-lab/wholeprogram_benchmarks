CC=gcc
SB_OPT=-O1 -Xclang -disable-llvm-passes

FILE1 = basicmath_small.c   rad2deg.c  cubic.c   isqrt.c
FILE2 = basicmath_large.c   rad2deg.c  cubic.c   isqrt.c

all: basicmath

basicmath: ${FILE2} Makefile
	$(CC) -static ${FILE2} -o basicmath -lm $(SB_OPT)

clean:
	rm -rf basicmath output*
