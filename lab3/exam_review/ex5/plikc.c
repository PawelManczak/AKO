#include <stdio.h>

extern __int64 suma_siedmiu_liczb(__int64 v1, __int64 v2, __int64 v3, \
	__int64 v4, __int64 v5, __int64 v6, __int64 v7);

int main() {
	__int64 tablica[7] = { 1, 2, 3, 1, 2, 3, 1 }, suma;
	suma = suma_siedmiu_liczb(tablica[0], tablica[1], tablica[2], \
		tablica[3], tablica[4], tablica[5], tablica[6]);
	printf("Suma tych 7 liczb : %I64d", suma);

	return 0;
}