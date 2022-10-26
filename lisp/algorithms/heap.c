#include <stdio.h>

int parent(int i) {
  return ((i+1)/2)-1;
}

int left(int i) {
  return ((i+1)*2)-1;
}

int right(int i) {
  // +1 then -1, just to keep the same form shape as the 1 indexed version
  return ((i+1)*2+1)-1;
}

void print(int *heap, int n) {
  for(int i=0; i<n; i++){
    int parent_index = parent(i);
    int left_index = left(i);
    int right_index = right(i);
    printf("i:%d val:%d\n", i+1, heap[i]);
    printf("    parent: i:%d val:%d\n", parent_index+1, heap[parent_index]);
    printf("    left: i:%d val:%d\n", left_index+1, heap[left_index]);
    printf("    right: i:%d val:%d\n", right_index+1, heap[right_index]);
  }
}

int main() {
  int example_heap[] = {16, 14, 10, 8, 7, 9, 3, 2, 4, 1};
  print(example_heap, 10);
}
