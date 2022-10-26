#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

#define DEBUG 0

struct SubArray {
	int start;
	int end;
	int sum;
};

struct SubArray max_subarray(int* A, int len) {
	int i, j, sum;
	struct SubArray rv;
	rv.sum = INT_MIN;
	for(i = 0; i < len; i++) {
		sum = A[i];
		if(sum > rv.sum) {
			rv.start = i;
			rv.end = i+1;
			rv.sum = sum;
		}
		for(j = i+1; j < len; j++) {
			sum = sum + A[j];
			if(sum > rv.sum) {
				rv.start = i;
				rv.end = j+1;
				rv.sum = sum;
			}
		}
	}

	return rv;
}

int main(int argc, char** argv) {
	int i, v, len;

	struct SubArray result;

	int* A = (int*) malloc(sizeof(int) * 10000000);

	len = 0;
	while(len < 10000000 && scanf("%d", &A[len]) != EOF) {
		len++;
	}

	result = max_subarray(A, len);

	printf("\n\nresult: A[%d:%d] == %d\n", result.start, result.end, result.sum);
}


