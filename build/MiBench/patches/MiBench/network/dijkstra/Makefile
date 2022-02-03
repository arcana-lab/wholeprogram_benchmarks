CC=gcc
SB_OPT=-O1 -Xclang -disable-llvm-passes

all: dijkstra

dijkstra: dijkstra_large.c Makefile
	$(CC) -static dijkstra_large.c -o dijkstra $(SB_OPT)

dijkstra_small: dijkstra_small.c Makefile
	$(CC) -static dijkstra_small.c -o dijkstra_small 

clean:
	rm -rf dijkstra_* output*
