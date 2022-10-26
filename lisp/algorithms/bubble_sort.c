#include <stdio.h>
#include <stdlib.h>

void bubble_sort(int *A, int len) {
	int i, j, tmp;

	for(i = 0; i < len-1; i++) {
		for(j = len-1; j >= i+1; j--) {
			if(A[j] < A[j-1]) {
				tmp = A[j];
				A[j] = A[j-1];
				A[j-1] = tmp;
			}
		}
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

	bubble_sort(keys, len);
	for(i = 0; i < len; i++) {
		printf("%d ", keys[i]);
	}

}
