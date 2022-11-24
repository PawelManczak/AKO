#include <stdio.h>
int sum(unsigned int n, ...);

int main() {  
	int suma = sum(5, 1, 2, 3, 4, 5);  
	printf("Wynik : %d", suma);  
	return 0;
}