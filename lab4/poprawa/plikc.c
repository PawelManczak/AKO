#include <stdio.h>
#include <xmmintrin.h>

float *wieksze(__m128 *tablica1, unsigned int n, int dzielnik);
int main() {  
	__m128 tablica[3] = { (__m128) { 6.0f, 3.0f, 4.0f, 5.0f },
						(__m128) {1.0f, 3.0f, 4.0f, 5.0f},
						(__m128) {1.0f, 9.0f, 6.0f, 9.0f} };
	float* nowa_tablica;

	nowa_tablica = wieksze(tablica, 3, 1);
	for (int i = 0; i < 4; i++) {
		printf("%d = %f\n", i, nowa_tablica[i]);
	}

	free(nowa_tablica);
	return 0;
}