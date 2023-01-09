#include <stdio.h>

float avg_wd(int n, void* tablica, void* wagi);

int main()
{
    float tablica[5] = { 3.0f, 3.0f, 3.0f, 3.0f, 3.0f };
    float wagi[5] = { 1.0f, 1.0f, 1.0f, 1.0f, 1.0f };
    float srednia = avg_wd(5, tablica, wagi);
    printf("Srednia to %f", srednia);

    return 0;
}