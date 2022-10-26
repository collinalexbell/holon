#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#define MAX_N 1000000

void matrix_multiply(int n, int A[n][n], int B[n][n], int C[n][n]) {
	int i, j, k, sum;

	for(i = 0; i < n; i++){
		for(j = 0; j < n; j++) {
			sum = 0;
			for(k = 0; k < n; k++) {
				sum = sum + A[i][k] * B[k][j];
			}
			C[i][j] = sum;
		}
	}
}

int main(int argc, char** argv) {
	int i, j, n;
	int eof;

	if(argc < 2) {
		fprintf(stderr, "usage: ./matrix_multiply_naive.exe <n>\n");
		exit(1);
	}

	n = atoi(argv[1]);	
	if(n < 0 || n > MAX_N) {
		fprintf(stderr,"invalid n:%d for (n x n)	 matrix", n);
	}

	int A[n][n];
	int B[n][n];
	int C[n][n];


	for(i = 0; i < n; i++) {
		for(j = 0; j < n; j++) {
			scanf("%d", &A[i][j]);
		}
	}

	for(i = 0; i < n; i++) {
		for(j = 0; j < n; j++) {
			eof = scanf("%d", &B[i][j]);
		}
	}

	if(eof == EOF) {
		fprintf(stderr, "not enough data provided to stdin\n");
		exit(1);
	}

	matrix_multiply(n, A, B, C);

	for(i = 0; i < n; i++) {
		for(j = 0; j < n; j++) {
			printf("%d ", C[i][j]);
		}
		printf("\n");
	}
}
