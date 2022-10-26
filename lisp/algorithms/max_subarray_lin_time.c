#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

#define DEBUG 0

struct SubArray {
	int start;
	int end;
	int sum;
};

struct SubArray max_subarray(int *A,  int len) {
	int i;
	struct SubArray max, max_with_current;

	max.sum = INT_MIN;
	max.start = -1;
	max.end = -1;


	max_with_current.sum = 0;
	max_with_current.start = -1;
	max_with_current.end = -1;

	for(i = 0; i < len; i++) {
		if(max_with_current.sum > 0) {
			max_with_current.sum = max_with_current.sum + A[i];
			max_with_current.end = i + 1;
		} else {
			max_with_current.sum =  A[i];
			max_with_current.start = i;
			max_with_current.end = i + 1;
		}

		if(max_with_current.sum > max.sum) {
			max.start = max_with_current.start;
			max.end = max_with_current.end;
			max.sum = max_with_current.sum;
		}
	}

	return max;
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

	free(A);
}


