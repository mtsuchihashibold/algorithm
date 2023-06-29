#include <stdio.h>
#include <stdlib.h>
#include <time.h>

// start
// l,r: 62746.12287518519, 62746.129980612546
// func: 999997.801965372, check: 2.1980346279451624
// log10: 4.7975869448161
// end
// mtsuchihashi@29Apr2022-rainy:~/datas/project/prgcontest/practice/typical90$ node index.js 
// start
// l,r: 4523071.24299825, 4523071.251671867
// func: 99999994.22122249, check: 5.77877750992775
// log10: 6.655433429214896
// end

#define L 62746

int crand(int n)
{
  return 0 + (int)(rand() * (n - 0.0 + 1.0)/(1.0 + RAND_MAX) );
}

void suffule(int *a, int size)
{
  srand((unsigned int)time(NULL));
  for ( int i = size - 1 ; i >= 1; i-- ) {
	int j = crand(i);
	int tmp = a[j];
	a[j] = a[i];
	a[i] = tmp;
  }
}

void printarr(int *a, int size)
{
  for ( int i = 0 ; i < size - 1; i++ ) {
	printf("%d ", a[i]);
  }
  printf("%d", a[size - 1]);
}

int main(int argc, char *argv[])
{
  // int a[4523071];
   
  // int a[62746] = {0};
  //  printf("argc: %d\n", argc);
  if ( argc != 2 ) {
	puts("input capacity");
	return 1;
  }
  
  int l = atoi(argv[1]);
  printf("%d\n", l);
  //int a[l] = {0};
  int a[l];
  for (int i = 0 ; i < l ; i++ ) {
	a[i] = i;
  }
  suffule(a, l);
  printarr(a, l);
  printf("\n");
  return 0;
}  
