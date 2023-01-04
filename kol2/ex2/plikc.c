#include <stdio.h>
#include <xmmintrin.h>

int* kopia_tablicy(int tabl[], unsigned int n);
int main() {  
	int tab[5] = { 1,2,3,4,5 };
	int* tab2;
	tab2 = kopia_tablicy(tab, 5);

	for (int i = 0; i < 5; i++) {
		printf("%d", tab2[i]);
	}
	
	return 0;
}