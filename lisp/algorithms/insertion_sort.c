#include <stdio.h>
#include <stdlib.h>

void sort(int *keys, int len) {
	int i, j, val;
	for (i = 1; i < len; i++) {
		val = keys[i];
		for (j = i-1; j >= 0 && val < keys[j]; j--) {
			keys[j+1] = keys[j];
		}
		keys[j+1] = val;
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
