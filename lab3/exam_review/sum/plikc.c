#include <stdio.h>

int sum(unsigned int n, ...);

int main() {

	int suma = sum(3, -3, -2, -1);
	printf("Wynik : %d", suma);

	return 0;
}