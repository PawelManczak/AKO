#include <stdio.h>
int negacja(int* m);

int main() {
	int m = -5423;
	negacja(&m);

	printf("\\n m = %d\\n", m);

	return 0;
}