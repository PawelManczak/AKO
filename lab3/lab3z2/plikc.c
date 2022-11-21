#include <stdio.h>
int przeciwna(int *a);
int main()
{
	int m = 123;
	przeciwna(&m);

	printf("\n m = %d\n", m);
	return 0;
}