CC=gcc

FILE1 = bmhasrch.c  bmhisrch.c  bmhsrch.c  pbmsrch_small.c 
FILE2 = bmhasrch.c  bmhisrch.c  bmhsrch.c  pbmsrch_large.c 

all: search

search_small: ${FILE1} Makefile
	$(CC) -static ${FILE1} -O3 -o search_small

search: ${FILE2} Makefile
	$(CC) -static ${FILE2} -O3 -o search

clean:
	rm -rf search search_* output*
