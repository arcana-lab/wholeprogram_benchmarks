CC=gcc
SB_OPT=-O1 -Xclang -disable-llvm-passes

FILE1 = bmhasrch.c  bmhisrch.c  bmhsrch.c  pbmsrch_small.c 
FILE2 = bmhasrch.c  bmhisrch.c  bmhsrch.c  pbmsrch_large.c 

all: search

search_small: ${FILE1} Makefile
	$(CC) -static ${FILE1} -O1 -o search_small

search: ${FILE2} Makefile
	$(CC) -static ${FILE2} -O1 -o search $(SB_OPT)

clean:
	rm -rf search search_* output*
