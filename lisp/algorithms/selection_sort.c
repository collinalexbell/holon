#include <stdio.h>
#include <stdlib.h>

void sort(int *keys, int len) {
	int i, j, min, tmp; 
	for(i = 0; i < len-1; i++){
		min = i;

		// Find smallest
		for(j = i; j < len; j++) {
			if(keys[j] < keys[min]) {
				min = j;
			}
		}

		// Swap
		tmp = keys[i];
		keys[i] = keys[min];
		keys[min] = tmp;
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

	sort(keys, len);
	for(i = 0; i < len; i++) {
		printf("%d, ", keys[i]);
	}
	printf("\n");
}
