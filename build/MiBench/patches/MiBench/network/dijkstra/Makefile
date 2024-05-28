CC=clang
SB_OPT=-O1 -Xclang -disable-llvm-passes

all: dijkstra

dijkstra: dijkstra_large.c
	$(CC) -static dijkstra_large.c -o dijkstra $(SB_OPT)

dijkstra_small: dijkstra_small.c
	$(CC) -static dijkstra_small.c -o dijkstra_small 

clean:
	rm -rf *.bc *.ll *.o dijkstra output*
