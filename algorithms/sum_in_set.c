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

/*
 * A[p:q] and A[q:r] are the 2 arrays to be merged .
 * The min index is inclusive and the max index is exclusive.
 * This is unlike the book's psuedo code where the max indicies are inclusive.
 */
void merge(int *A, int p, int q, int r) {
	int i, lInd, rInd;

	int lenLeft = q - p;
	int left[lenLeft + 1];
	for(i = 0; i < lenLeft; i++) {
		left[i] = A[p + i];
	}
	left[lenLeft] = 2147483647;

	int lenRight = r - q;
	int right[lenRight + 1];
	for(i = 0; i < lenRight; i++) {
		right[i] = A[q + i];
	}
	right[lenRight] = 2147483647;

	lInd = 0;
	rInd = 0;

	for(i = 0; i < lenLeft + lenRight; i++) {
		if(left[lInd] <= right[rInd]) {
			A[p + i] = left[lInd];
			lInd++;	
		} else {
			A[p + i] = right[rInd];
			rInd++;
		}
	}
}

void merge_sort(int *A, int p, int r) {
	if(r-p > 1) {
		int q = (r+p)/2;
		merge_sort(A, p, q);
		merge_sort(A, q, r);
		merge(A, p, q, r);
	}
}

void sum_in_set(int *S, int sum, int len, int *rv) {
	int i, needle;
	merge_sort(S, 0, len);
	for(i = 0; i < len; i++) {
		rv[0] = i;
		needle = sum - S[i];
		rv[1] = binary_search(S, needle, 0, len);
		if(rv[1] > -1) return;
	}
	rv[0] = -1;
	rv[1] = -1;
}

int main(int argc, char** argv) {
	int i, v, len, result[2];
	if(argc < 2) {
		printf("usage: sum_in_set <sum>\n");
		exit(1);
	}

	int S[10000];

	v = atoi(argv[1]);

	len = 0;
	while(len < 10000 && scanf("%d", &S[len]) != EOF) {
		len++;
	}


	for(i = 0; i < len; i++) {
		printf("%d, ", S[i]);
	}
	printf("\n");

	sum_in_set(S, v, len, result);

	printf("\n\nresult: S[%d], S[%d] == (%d, %d)\n", result[0], result[1], S[result[0]], S[result[1]]);
}




