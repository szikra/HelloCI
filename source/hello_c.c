#include <stdio.h>

int main(void) {
	printf("Hello C CI\r\n");
	*(int*)1 = 1; /// Seg Fault Runtime error Test
	return 0;
}