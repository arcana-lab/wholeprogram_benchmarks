#include "snipmath.h"
#include <math.h>

/* The printf's may be removed to isolate just the math calculations */

// separating the hot loop to its own function is required 
// to recognize x as clonable (even when declared inside the loop)
void hot_loop(void) {
  int upperBound = 1000; // ED
  // replace reused variables with local versions.
  for (double local_a1 = 1; local_a1 < upperBound; local_a1 += 1) {
    for (double local_b1 = 10; local_b1 > 0; local_b1 -= .25) {
      for (double local_c1 = 5; local_c1 < upperBound; local_c1 += 0.61) {
        for (double local_d1 = -1; local_d1 > -5; local_d1 -= .451) {
          // x is tricky. only the first `solutions` values
          // are written and read each iteration, but
          // otherwise it looks like a loop-carried dependence
          // if declared outside of the loop
          int local_solutions;
          double local_x[3];
          SolveCubic(local_a1, local_b1, local_c1, local_d1, &local_solutions,
                     local_x);
          printf("Solutions:");
          for (int local_i = 0; local_i < local_solutions; local_i++)
            printf(" %f", local_x[local_i]);
          printf("\n");
        }
      }
    }
  }
  return;
}

int main(void)
{

  double  a1 = 1.0, b1 = -10.5, c1 = 32.0, d1 = -30.0;
  double  x[3];
  double X;
  int     solutions;
  int i;
  unsigned long l = 0x3fed0169L;
  struct int_sqrt q;
  long n = 0;

  /* solve soem cubic functions */
  printf("********* CUBIC FUNCTIONS ***********\n");
  /* should get 3 solutions: 2, 6 & 2.5   */
  SolveCubic(a1, b1, c1, d1, &solutions, x);  
  printf("Solutions:");
  for(i=0;i<solutions;i++)
    printf(" %f",x[i]);
  printf("\n");

  a1 = 1.0; b1 = -4.5; c1 = 17.0; d1 = -30.0;
  /* should get 1 solution: 2.5           */
  SolveCubic(a1, b1, c1, d1, &solutions, x);  
  printf("Solutions:");
  for(i=0;i<solutions;i++)
    printf(" %f",x[i]);
  printf("\n");

  a1 = 1.0; b1 = -3.5; c1 = 22.0; d1 = -31.0;
  SolveCubic(a1, b1, c1, d1, &solutions, x);
  printf("Solutions:");
  for(i=0;i<solutions;i++)
    printf(" %f",x[i]);
  printf("\n");

  a1 = 1.0; b1 = -13.7; c1 = 1.0; d1 = -35.0;
  SolveCubic(a1, b1, c1, d1, &solutions, x);
  printf("Solutions:");
  for(i=0;i<solutions;i++)
    printf(" %f",x[i]);
  printf("\n");

  a1 = 3.0; b1 = 12.34; c1 = 5.0; d1 = 12.0;
  SolveCubic(a1, b1, c1, d1, &solutions, x);
  printf("Solutions:");
  for(i=0;i<solutions;i++)
    printf(" %f",x[i]);
  printf("\n");

  a1 = -8.0; b1 = -67.89; c1 = 6.0; d1 = -23.6;
  SolveCubic(a1, b1, c1, d1, &solutions, x);
  printf("Solutions:");
  for(i=0;i<solutions;i++)
    printf(" %f",x[i]);
  printf("\n");

  a1 = 45.0; b1 = 8.67; c1 = 7.5; d1 = 34.0;
  SolveCubic(a1, b1, c1, d1, &solutions, x);
  printf("Solutions:");
  for(i=0;i<solutions;i++)
    printf(" %f",x[i]);
  printf("\n");

  a1 = -12.0; b1 = -1.7; c1 = 5.3; d1 = 16.0;
  SolveCubic(a1, b1, c1, d1, &solutions, x);
  printf("Solutions:");
  for(i=0;i<solutions;i++)
    printf(" %f",x[i]);
  printf("\n");

  /* Now solve some random equations */
  hot_loop();

  printf("********* INTEGER SQR ROOTS ***********\n");
  /* perform some integer square roots */
  int numOfSqrtRoots = 10000000; // ED
  for (i = 0; i < 100000; i+=2)
    {
      usqrt(i, &q);
			// remainder differs on some machines
     // printf("sqrt(%3d) = %2d, remainder = %2d\n",
     printf("sqrt(%3d) = %2d\n",
	     i, q.sqrt);
    }
  printf("\n");
  for (l = 0x3fed0169L; l < 0x3fed4169L; l++)
    {
	 usqrt(l, &q);
	 //printf("\nsqrt(%lX) = %X, remainder = %X\n", l, q.sqrt, q.frac);
	 printf("sqrt(%lX) = %X\n", l, q.sqrt);
    }


  printf("********* ANGLE CONVERSION ***********\n");
  /* convert some rads to degrees */
/*   for (X = 0.0; X <= 360.0; X += 1.0) */
  double step = 0.00001;
  for (X = 0.0; X <= 360.0; X += step)
    printf("%3.0f degrees = %.12f radians\n", X, deg2rad(X));
  puts("");
/*   for (X = 0.0; X <= (2 * PI + 1e-6); X += (PI / 180)) */
  for (X = 0.0; X <= (2 * PI + 1e-6); X += (PI / 5760))
    printf("%.12f radians = %3.0f degrees\n", X, rad2deg(X));

  
  return 0;
}
