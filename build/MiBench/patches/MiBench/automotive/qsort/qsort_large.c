#include <stdlib.h>
#include <stdio.h>
#include <math.h>

#define UNLIMIT
#define MAXARRAY 999999999 // ED: was 60000 /* this number, if too large, will cause a seg. fault!! */

struct my3DVertexStruct {
  int x, y, z;
  double distance;
};

int vertex_compare(const vertex_t *restrict elem1,
                   const vertex_t *restrict elem2) {
  /* D = [(x1 - x2)^2 + (y1 - y2)^2 + (z1 - z2)^2]^(1/2) */
  /* sort based on distances from the origin... */

  double distance1, distance2;

  distance1 = (*((vertex_t *)elem1)).distance;
  distance2 = (*((vertex_t *)elem2)).distance;

  return (distance1 > distance2) ? 1 : ((distance1 == distance2) ? 0 : -1);
}

void quicksort(off_t bottom, off_t top, vertex_t *restrict data) {
  off_t lower, upper;
  vertex_t temp;
  if (bottom >= top)
    return;

  vertex_t *pivot = &data[bottom];
  for (lower = bottom, upper = top; lower < upper;) {
    while (lower <= upper && vertex_compare(&data[lower], pivot) < 0) {
      lower++;
    }
    while (lower <= upper && vertex_compare(&data[upper], pivot) > 0) {
      upper--;
    }
    if (lower < upper) {
      temp = data[lower];
      data[lower] = data[upper];
      data[upper] = temp;
    }
  }

  temp = data[bottom];
  data[bottom] = data[upper];
  data[upper] = temp;

  quicksort(bottom, upper - 1, data);
  quicksort(upper + 1, top, data);
}


int
main(int argc, char *argv[]) {
  //struct my3DVertexStruct array[MAXARRAY];
  struct my3DVertexStruct *array = (struct my3DVertexStruct *) malloc(MAXARRAY*sizeof(struct my3DVertexStruct)); // ED: let's allocate this monster on the heap, rather on the stack

  FILE *fp;
  int i,count=0;
  int x, y, z;
  
  if (argc<2) {
    fprintf(stderr,"Usage: qsort_large <file>\n");
    exit(-1);
  }
  else {
    fp = fopen(argv[1],"r");
    
    while((fscanf(fp, "%d", &x) == 1) && (fscanf(fp, "%d", &y) == 1) && (fscanf(fp, "%d", &z) == 1) &&  (count < MAXARRAY)) {
	 array[count].x = x;
	 array[count].y = y;
	 array[count].z = z;
	 array[count].distance = sqrt(pow(x, 2) + pow(y, 2) + pow(z, 2));
	 count++;
    }
  }
  printf("\nSorting %d vectors based on distance from the origin.\n\n",count);
  quicksort(0, count, array);
  
  for(i=0;i<count;i++)
    printf("%d %d %d\n", array[i].x, array[i].y, array[i].z);
  return 0;
}
