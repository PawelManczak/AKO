#include <stdio.h>

float nowy_exp(float x);

int main() {
	float wynik, x = 2.0f;
	wynik = nowy_exp(x);
	printf("Wynikiem sumy 20 wyrazow ciagu dla x = %f jest : %f", x, wynik);

	return 0;
}