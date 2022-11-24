#include <stdio.h>
int* szukaj_elem_max(int tablica[], int n);
int main()
{
	int pomiary[7] = { 1, 423, 78, 32, 5, 14, 2 },  *wsk;  
	wsk = szukaj_elem_max(pomiary, 7); 
	printf("\nElement maksymalny = %d\n", *wsk);  
	return 0;

}