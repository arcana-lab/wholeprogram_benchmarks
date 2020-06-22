CC=gcc

susan: susan.c Makefile
	$(CC) -static -O4 -o susan susan.c -lm
	cp susan susan_c
	cp susan susan_e
	cp susan susan_s
	rm susan

clean:
	rm -rf susan susan_* output*
