#include <stdio.h>
int reduction(int tab[], unsigned int n, short reductionType);

int main() {  
	int tab[5] = { -1,-2, 5, 4, 3 }; 
// -1 MIN 0 SUMA 1 MAX  
	printf("test");
	int redukcja = reduction(tab, 5, 2);  
	printf("Wynik : %d", redukcja);  
	return 0;
}