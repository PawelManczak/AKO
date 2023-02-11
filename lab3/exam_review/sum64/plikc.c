#include <stdio.h>

int sum(unsigned int n, ...);

int main() {
	int suma = sum(7, 1, 1, 1, 1, 1, 1, 1);
	printf("Wynik : %d", suma);

	return 0;
}