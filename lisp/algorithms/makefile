CC = gcc -g
all: merge_sort binary_addition gensort insertion_sort insertion_sort_reverse linear_search selection_sort merge_sort_no_sentinels binary_search sum_in_set bubble_sort horners_rule inversions max_subarray max_subarray_brute_force max_subarray_test max_subarray_optimized max_subarray_lin_time matrix_multiply_naive matrix_multiply_strassen matrix_multiply_recursive heap

gensort: gensort.c
	$(CC) gensort.c -o gensort.exe

insertion_sort: insertion_sort.c
	$(CC) insertion_sort.c -o insertion_sort.exe

insertion_sort_reverse: insertion_sort_reverse.c
	$(CC) insertion_sort_reverse.c -o insertion_sort_reverse.exe

linear_search: linear_search.c
	$(CC) linear_search.c -o linear_search.exe

binary_addition: linear_search.c
	$(CC) binary_addition.c -o binary_addition.exe

selection_sort: selection_sort.c
	$(CC) selection_sort.c -o selection_sort.exe

merge_sort: merge_sort.c
	$(CC) merge_sort.c -o merge_sort.exe

merge_sort_no_sentinels: merge_sort_no_sentinels.c
	$(CC) merge_sort_no_sentinels.c -o merge_sort_no_sentinels.exe

binary_search: binary_search.c
	$(CC) binary_search.c -o binary_search.exe

sum_in_set: sum_in_set.c
	$(CC) sum_in_set.c -o sum_in_set.exe

bubble_sort: bubble_sort.c
	$(CC) bubble_sort.c -o bubble_sort.exe

horners_rule: horners_rule.c
	$(CC) horners_rule.c -o horners_rule.exe

inversions: inversions.c
	$(CC) inversions.c -o inversions.exe

max_subarray: max_subarray.c
	$(CC) max_subarray.c -o max_subarray.exe


max_subarray_brute_force: max_subarray_brute_force.c
	$(CC) max_subarray_brute_force.c -o max_subarray_brute_force.exe

max_subarray_test: max_subarray_test.c
	$(CC) max_subarray_test.c -o max_subarray_test.exe

max_subarray_optimized: max_subarray_optimized.c
	$(CC) max_subarray_optimized.c -o max_subarray_optimized.exe

max_subarray_lin_time: max_subarray_lin_time.c
	$(CC) max_subarray_lin_time.c -o max_subarray_lin_time.exe

matrix_multiply_naive: matrix_multiply_naive.c
	$(CC) matrix_multiply_naive.c -o matrix_multiply_naive.exe

matrix_multiply_strassen: matrix_multiply_strassen.c
	$(CC) matrix_multiply_strassen.c -o matrix_multiply_starssen.exe

matrix_multiply_recursive: matrix_multiply_recursive.c
	$(CC) matrix_multiply_recursive.c -o matrix_multiply_recursive.exe

heap: heap.c
	$(CC) heap.c -o heap.exe

clean: 
	rm *.exe

