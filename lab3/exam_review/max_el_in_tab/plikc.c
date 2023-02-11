#include <stdio.h>

int* szukaj_elem_max(int tablica[], int n);

int main() {
	int pomiary[7] = { 1, 4, 7, 8, 9, 14, 12 }, * wsk;
	wsk = szukaj_elem_max(pomiary, 7);
	printf("\\nElement maksymalny = %d\\n", *wsk);

	return 0;
}
