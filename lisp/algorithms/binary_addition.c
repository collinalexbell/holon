#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>

int max(int num1, int num2)
{
    return (num1 > num2 ) ? num1 : num2;
}

void binary_addition(int *a, int *b, int *c, int len) {
	int i, sum, carry;
	carry = 0;
	for(i = len-1; i >= 0; i--) {
		sum = a[i] + b[i] + carry;	
		c[i] = sum % 2;
		carry = sum / 2;
	}
}


int main(int argc, char** argv) {
	int i, len, alen, blen;
	char buffer[2];
	if(argc < 3) {
		printf("usage: binary_addition <binary num 1> <binary num 2>\n");
		exit(0);
	}

	
	buffer[1] = '\0';
	alen = strlen(argv[1]);
	blen = strlen(argv[2]);
	len = max(alen, blen) + 1;
	int a[len];	
	int b[len];	
	int c[len];

	for(i = 0; i < len; i++) {
		a[i] = 0;
		b[i] = 0;
	}
	
	
	for(i = alen-1; i >= 0; i--) {
		buffer[0] = argv[1][i];
		a[i + (len-alen)] = atoi(buffer);
		assert(a[i + (len-alen)] <= 1);
	}

	for(i = alen-1; i >= 0; i--) {
		buffer[0] = argv[2][i];
		b[i + (len-blen)] = atoi(buffer);
		assert(b[i + (len-blen)] <= 1);
	}

	binary_addition(a, b, c, len);

	printf("the sum of ");

	for(i = 0; i < len; i++) {
		printf("%d, ", a[i]);
	}
	printf(" + ");
	for(i = 0; i < len; i++) {
		printf("%d, ", b[i]);
	}
	printf(" = ");
	for(i = 0; i < len; i++) {
		printf("%d, ", c[i]);
	}
	printf("\n");
}
