#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main (int argc, char** argv) {
	int i, n, r;
	r = 10000;
	if(argc >= 2) n = atoi(argv[1]);
	else exit(0);

	if(argc >= 3) r = atoi(argv[2]);

	if(argc >= 4) {
		srand(atoi(argv[3]));
	} else {
		srand(time(0));
	}

	int sign;
	for(i = 0; i < n; i++) {
		sign = ((rand() % 2) == 1) ? -1 : 1;
		printf("%d ", (rand() % r) * sign);
	}
}
