#include <stdio.h>
void przestaw(int tabl[], int n);

int main()
{
	int tab[] = {1, 3, 4, 1 };
	int n = 4;
	int t_rozmiar = n;
	//zmniejszamy t_rozmiar, bo zakladamy, ze to juz posortowane
	for (int i = 0; i < n-1; i++) {

			przestaw(tab, t_rozmiar);
			t_rozmiar--;
	}


	//scanf_s("%d", &k, 12);
	for (int i = 0; i < n; i++) {
		printf("%d ", tab[i]);
	}
	
	return 0;
}