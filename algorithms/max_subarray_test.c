#include <stdlib.h>
#include <stdio.h>
#include <sys/time.h>
#include <time.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

struct RunStat {
	long int brute_force;
	long int recursive;
};

struct RunStat run(int n) {
	struct timeval times[4];
	char gensort_cmd [256];
	int len;
	
	// create list of n digits between -1000 to 1000 and seed generator with n
	sprintf(gensort_cmd, "./gensort.exe %d 1000 %ld", n, (n + time(NULL)));
	FILE* gensort = popen(gensort_cmd, "r");

	int* A = (int*) malloc(sizeof(int) * n);

	len = 0;
	while(len < n && fscanf(gensort, "%d", &A[len]) != EOF) {
		len++;
	}
	wait(NULL);
	pclose(gensort);

	gettimeofday(&times[0], NULL);
	FILE* brute_force_f = popen("./max_subarray_brute_force.exe > /dev/null", "w");
	for(int i = 0; i < n; i++) {
		fprintf(brute_force_f, "%d ", A[i]);
	}
	fprintf(brute_force_f, "\n");
	pclose(brute_force_f);
	wait(NULL);
	gettimeofday(&times[1], NULL);


	gettimeofday(&times[2], NULL);
	//Change this to be max_subarray_optimized.exe to run part b
	FILE* recursive_f = popen("./max_subarray.exe > /dev/null", "w");
	for(int i = 0; i < n; i++) {
		fprintf(recursive_f, "%d ", A[i]);
	}
	fprintf(recursive_f, "\n");
	pclose(recursive_f);
	wait(NULL);
	gettimeofday(&times[3], NULL);



	long int millis[4];
	for(int i = 0; i < 4; i++) {
		millis[i] = times[i].tv_sec * 1000000 + times[i].tv_usec;
	}
	struct RunStat rv = {millis[1]-millis[0], millis[3]-millis[2]};
	free(A);
	return rv;
}

int main(int argc, char** argv) {
	long long int sum_brute_force = 0;
	long long int sum_recursive = 0;
	// queue
	struct RunStat kernel[10];
	struct RunStat best, tmp;
	int best_n, avg_n;
	int times = 5;
	
	char buff[10];
	if(argc >= 2) {
		sscanf(argv[1], "%d", &times);
	}

	avg_n = 0;

	for(int j = 0; j < times; j++) {
		printf("time #: %d\n", j);
		best.brute_force = 10000000;
		best.recursive = 0;
		for(int n = 10; n < 1000; n++) {
			kernel[n%10] = run(n);
			if(n >= 20) {
				sum_brute_force =	0;
				sum_recursive = 0;
				for(int i = 0; i < 10; i++) {
					sum_brute_force = sum_brute_force + kernel[i].brute_force;
					sum_recursive = sum_brute_force + kernel[i].recursive;
					tmp.brute_force = sum_brute_force;
					tmp.recursive = sum_recursive;
				}
				if(abs(tmp.brute_force - tmp.recursive) < abs(best.brute_force - best.recursive)) {
					best = tmp;
					best_n = n - 5;
				}
			}
		}
		avg_n = avg_n + best_n;
		printf("crossover n:%d\n", best_n);
	}
	avg_n = avg_n / times;
	printf("\n");
	printf("average crossover n:%d\n", avg_n);
}
