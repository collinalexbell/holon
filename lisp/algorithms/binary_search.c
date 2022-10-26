#include <stdio.h>
#include <stdlib.h>

int binary_search(int *A, int needle, int lower, int upper) {
	// base
	if((upper - lower) <= 1) {
		if(A[lower] == needle) return lower;
		else return -1;
	}

	// recurse
	int pivot = (upper-lower)/2 + lower;
	if(needle < A[pivot]) return binary_search(A, needle, lower, pivot);
	else return binary_search(A, needle, pivot, upper);
}

int main(int argc, char** argv) {
	int i, v, len, result;
	if(argc < 2) {
		printf("usage: binary_search <value_to_search>\n");
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


	result = binary_search(A, v, 0, len);

	printf("\n\nresult: A[%d] == %d\n", result, A[result]);
}


