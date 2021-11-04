CC=gcc
SB_OPT=-O1 -Xclang -disable-llvm-passes

susan: susan.c Makefile
	$(CC) -static -O4 -o susan susan.c -lm $(SB_OPT)
	cp susan susan_c
	cp susan susan_e
	cp susan susan_s
	rm susan

clean:
	rm -rf susan susan_* output*
