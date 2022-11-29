#include <stdio.h>
int wyswietl(wchar_t tablica[], wchar_t znak, wchar_t **wynnik);

int main() {  
	wchar_t tab1[] = L"abcdefga";
	wchar_t* wyn;
	unsigned int count;

	count = wyswietl(tab1, L'a', &wyn);

	printf("licznik=%u\n", count);
	printf("\nw = %ls licznik=%u\n", wyn, count);  

	return 0;
}