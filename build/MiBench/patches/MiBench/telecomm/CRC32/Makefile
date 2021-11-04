CC=gcc
SB_OPT=-O1 -Xclang -disable-llvm-passes

crc: crc_32.c Makefile
	$(CC) -static crc_32.c -O1 -o crc $(SB_OPT) 

clean:
	rm -rf crc output*
