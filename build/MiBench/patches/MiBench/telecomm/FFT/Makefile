CC=gcc
SB_OPT=-O0 -Xclang -disable-O0-optnone

OBJ = main.o fftmisc.o  fourierf.o
FILE = main.c fftmisc.c  fourierf.c
CFLAGS = -static -O3 -g

fft: ${OBJ} Makefile
	$(CC) ${CFLAGS} ${OBJ} -o fft -lm $(SB_OPT)
	cp fft fft_inv
fftmisc.o: fftmisc.c
	$(CC) ${CFLAGS} -c fftmisc.c $(SB_OPT)
fourierf.o: fourierf.c
	$(CC) ${CFLAGS} -c fourierf.c $(SB_OPT)
main.o: main.c
	$(CC) ${CFLAGS} -c main.c $(SB_OPT)

clean:
	rm -rf *.o fft output*
