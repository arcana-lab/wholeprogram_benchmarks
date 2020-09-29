CC=gcc
SB_OPT=-O0 -Xclang -disable-O0-optnone

crc: crc_32.c Makefile
	$(CC) -static crc_32.c -O1 -o crc $(SB_OPT) 

clean:
	rm -rf crc output*
