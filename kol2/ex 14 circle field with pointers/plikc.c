#include <stdio.h>
void pole_kola(float* pr);
int main()
{
	float k = 2.0f;
	pole_kola(&k);
	printf("\nPole ko�a wynosi %f\n", k);
	return 0;
}