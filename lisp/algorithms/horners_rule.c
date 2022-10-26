#include <stdio.h>
#include <stdlib.h>

int horners_rule(int *a, int x, int k, int len) {
	if(k < len) {
		return a[k] + x * horners_rule(a, x, k+1, len);	
	} 
	return 0;
}

int naive(int *a, int x, int k, int len) {
	int i;
	if(k < len) {
		int xToK = 1;
		for(i = 0; i < k; i++) {
			xToK = xToK * x;
		}
		return a[k] * xToK + naive(a, x, k+1, len);
	}
	return 0;
}

int main(int argc, char** argv) {
	int i, x, len, resultHorners, resultNaive;

	int a[100];

	if(argc < 2) {
		printf("usage: ./horners_rule.exe <x>");
		exit(1);
	}

	x = atoi(argv[1]);

	len = 0;
	while(len < 100 && scanf("%d", &a[len]) != EOF) {
		len++;
	}


	for(i = 0; i < len; i++) {
		printf("%d, ", a[i]);
	}
	printf("\n");


	resultHorners = horners_rule(a, x, 0, len);
	resultNaive = naive(a, x, 0, len);

	printf("\n\nHorners Rule  result: y=%d\n", resultHorners);
	printf(    "Naive Compute result: y=%d\n", resultNaive);
}


