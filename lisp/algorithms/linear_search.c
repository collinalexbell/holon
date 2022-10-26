#include <stdio.h>
#include <stdlib.h>

int linear_search(int *A, int v, int len) {
	int i;
	for(i = 0; i < len; i++) {
		if(A[i] == v) {
			return i;
		}
	}
	return -1;
}

int main(int argc, char** argv) {
	int i, v, len, result;
	if(argc < 2) {
		printf("usage: linear_search <value_to_search>\n");
		exit(1);
	}

	int A[10000];

	v = atoi(argv[1]);

	len = 0;
	while(len < 10000 && scanf("%d", &A[len]) != EOF) {
		len++;
	}


	for(i = 0; i < len; i++) {
		printf("%d, ", A[i]);
	}
	printf("\n");


	result = linear_search(A, v, len);

	printf("\n\nresult: A[%d] == %d\n", result, A[result]);
}


