#include <stdio.h>
#include <stdlib.h>

/*
 * A[p:q] and A[q:r] are the 2 arrays to be merged .
 * The min index is inclusive and the max index is exclusive.
 * This is unlike the book's psuedo code where the max indicies are inclusive.
 */
void merge(int *A, int p, int q, int r) {
	int i, lInd, rInd;

	int lenLeft = q - p;
	int left[lenLeft];
	for(i = 0; i < lenLeft; i++) {
		left[i] = A[p + i];
	}

	int lenRight = r - q;
	int right[lenRight];
	for(i = 0; i < lenRight; i++) {
		right[i] = A[q + i];
	}

	lInd = 0;
	rInd = 0;

	for(i = 0; i < lenLeft + lenRight; i++) {
		if(lInd < lenLeft && (rInd >= lenRight || left[lInd] <= right[rInd])) {
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

int main(int argc, char **argv) {
	int i, len;
	if(argc > 1) len = atoi(argv[1]);
	else len = 100;
	int keys[len];

	for(i = 0; i < len; i++) {
		if(scanf("%d", &keys[i]) == EOF) break;
	}
	len = i;
	printf("\n");

	merge_sort(keys, 0, len);
	for(i = 0; i < len; i++) {
		printf("%d, ", keys[i]);
	}
	printf("\n");

}
