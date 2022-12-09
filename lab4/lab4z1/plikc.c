#include <stdio.h>
float srednia_harm(float* tablica, unsigned int n);
int main() {  
	float tablica[5] = { 2.0f, 3.0f, 4.0f, 5.0f, 6.0f }, wynik;  
	unsigned int n = 5;
	wynik = srednia_harm(tablica, n); 
	printf("Wynikiem sredniej harmonicznej jest : %f", wynik);  
	return 0;
}