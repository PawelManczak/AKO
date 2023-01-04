#include <stdio.h>
#include <xmmintrin.h>

int* szukaj_elem_min(int tablica[], int n);
int main() {  
	int pomiary[7] = { 7,4,8,4,5,6,7 }, *wsk;
	wsk = szukaj_elem_min(pomiary, 7);
	printf("\nElement minimalny = %d\n", *wsk);

	return 0;
}