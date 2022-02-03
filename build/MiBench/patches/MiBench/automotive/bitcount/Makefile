CC=gcc
SB_OPT=-O1 -Xclang -disable-llvm-passes

FILE = bitcnt_1.c bitcnt_2.c bitcnt_3.c bitcnt_4.c bitcnts.c bitfiles.c bitstrng.c bstr_i.c 

bitcnts: ${FILE} Makefile
	$(CC) -static ${FILE} -o bitcnts $(SB_OPT)

clean:
	rm -rf bitcnts output*
