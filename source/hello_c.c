#include <stdio.h>

void fail2link(void);

int main(void) {
	printf("Hello C CI\r\n");

#ifdef TEST_FAIL_TO_COMPILE
	fail2compile;
#endif

#ifdef TEST_FAIL_TO_LINK
	fail2link();
#endif

#ifdef TEST_FAIL_TO_RUN
	*(int*)1 = 1; /// Seg Fault Runtime error Test
#endif

#ifdef TEST_FAIL_TO_TEST
	return 1;
#else
	return 0;
#endif
}