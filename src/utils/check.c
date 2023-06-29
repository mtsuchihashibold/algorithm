#include <stdio.h>


int main(int argc, char *argv[])
{
  int n = -1;
  scanf("%d", &n);
  int a[n];
  for(int i = 0; i < n; i++ ) scanf("%d", &a[i]);
  for(int i = 0; i < n - 1; i++ ) printf("%d ", a[i]);
  printf("%d\n", a[n-1]); 

  
  int ans[n];
  for ( int i = 0 ; i < n ; i++ ) {
	int k = i;
	for ( int j = i ; j < n ; j++ ) {
	  if ( a[j] < a[k]) {
		k = j;
	  }
	}
	// printf("i: %d, k: %d, a[i]: %d, a[k]: %d\n", i, k, a[i], a[k]);
	int tmp = a[i];
	a[i] = a[k];
	a[k] = tmp;
  }

  for(int i = 0; i < n - 1; i++ ) printf("%d ", a[i]);
  printf("%d\n", a[n-1]); 
  
}
