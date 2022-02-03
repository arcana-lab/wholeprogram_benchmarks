CC=gcc
SB_OPT=-O1 -Xclang -disable-llvm-passes

crc: crc_32.c Makefile
	$(CC) -static crc_32.c -o crc $(SB_OPT) 

clean:
	rm -rf crc output*
