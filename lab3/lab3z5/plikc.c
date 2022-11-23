#include <stdio.h>
__int64 suma_siedmiu_liczb(__int64 v1, __int64 v2, __int64
	v3, __int64 v4, __int64 v5, __int64 v6, __int64 v7);
int main()
{
	__int64 wyniki[7] =
	{ 1, 1, 1, 1, 1, 1, 1};
	__int64 suma;
	suma = suma_siedmiu_liczb(wyniki[0], wyniki[1], wyniki[2], wyniki[3], wyniki[4], wyniki[5], wyniki[6]);
	printf("\nSuma 7 elementow wynosi %I64d\n",	suma);

	return 0;
}