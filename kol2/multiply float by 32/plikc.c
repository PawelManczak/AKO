#include <stdio.h>
#include <math.h>

float przemnoz(float a);

int main() {
    float a = -5.0f;
    float wynik = przemnoz(a);
    printf("Wynik mnozenia %f*32 to %f", a, wynik);
    return 0;
}