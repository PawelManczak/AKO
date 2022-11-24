#include <stdio.h>
int sum(unsigned int n, ...);

int main() {  
	int suma = sum(4, -3, -2, -1, 5);  
	printf("Wynik : %d", suma);  
	return 0;
}