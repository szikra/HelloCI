#include <stdio.h>

void fail2link(void);

#ifdef TEST_FAIL_TO_COVER
void unused_function(void) {
	printf("Unused\r\n");	
}

void partly_used_function(int i) {
	if (i) {
		printf("Path 1\r\n");	
	} else {
		printf("Path 0\r\n");	
	}
}
#endif


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

#ifdef TEST_FAIL_TO_COVER
	printf("Coverage Test\r\n");	
	if (0) {
		printf("Unreachable\r\n");	
	} else {
		printf("Reachable\r\n");	
	}
	partly_used_function(2);
#endif

#ifdef TEST_FAIL_TO_TEST
	return 1;
#else
	return 0;
#endif
}