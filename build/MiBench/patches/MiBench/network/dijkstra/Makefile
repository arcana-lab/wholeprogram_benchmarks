CC=gcc
SB_OPT=-O1 -Xclang -disable-llvm-passes

all: dijkstra

dijkstra: dijkstra_large.c Makefile
	$(CC) -static dijkstra_large.c -O1 -o dijkstra $(SB_OPT)

dijkstra_small: dijkstra_small.c Makefile
	$(CC) -static dijkstra_small.c -O1 -o dijkstra_small 

clean:
	rm -rf dijkstra_* output*
