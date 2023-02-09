#include <stdio.h>

int szukaj4_max(int a, int b, int c, int d);

int main() {
	int v, x, y, z, wynik;
	printf("\\nProsze podac cztery liczby calkowite ze znakiem: ");
	scanf_s("%d %d %d %d", &v, &x, &y, &z, 32);

	wynik = szukaj4_max(v, x, y, z);

	printf("\\nSposrod podanych liczb %d ,%d, %d, %d, liczba %d jest najwieksza", v, x, y, z, wynik);

	return 0;
}