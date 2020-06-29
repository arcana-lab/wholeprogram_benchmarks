CC=gcc
SB_OPT=-O0 -Xclang -disable-O0-optnone

all: dijkstra

dijkstra: dijkstra_large.c Makefile
	$(CC) -static dijkstra_large.c -O3 -o dijkstra $(SB_OPT)

dijkstra_small: dijkstra_small.c Makefile
	$(CC) -static dijkstra_small.c -O3 -o dijkstra_small 

clean:
	rm -rf dijkstra_* output*
