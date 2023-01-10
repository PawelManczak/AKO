#include <stdio.h>
#include <math.h>

unsigned int NWD(unsigned int a, unsigned int b);

int main() {
    unsigned int a = 12, b = 8;
    unsigned int wynik = NWD(a, b);
    printf("NWD liczb %d i %d = %d", a, b, wynik);

    return 0;
}