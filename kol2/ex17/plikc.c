#include <stdio.h>

unsigned __int64 sortowanie(unsigned __int64* tab1, unsigned int n);

int main()
{
    unsigned __int64 tab[6] = { 5, 4, 7, 6, 8, 9 };
    unsigned __int64 najwieksza = sortowanie(tab, 6);

    printf("Tablica po posortowaniu : ");
    for (int i = 0; i < 6; i++) {
        printf("%I64u ", tab[i]);
    }
    printf("\nNajwiekszy element : %I64u", najwieksza);

    return 0;
}