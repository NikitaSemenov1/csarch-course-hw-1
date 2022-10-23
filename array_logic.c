#include <stdlib.h>
#include <stdio.h>

static const int NMAX = 1000000;

int *alloc_array(size_t len) {
    return malloc(4 * len);
}

void free_array(int *array) {
    free(array);
}

void input_array(FILE *file, int array[], size_t len) {
    for (size_t i = 0; i < len; i++) {
        fscanf(file, "%d", &array[i]);
    }
}

int validate_size(int n) {
    return n < 0 || n > NMAX;
}

void print_array(FILE *file, int array[], size_t len) {
    for (size_t i = 0; i < len; i++) {
        fprintf(file, "%d ", array[i]);
    }
    printf("\n");
}

void build_array(const int a[], int b[], size_t len) {
    for (size_t i = 0; i < len; i++) {
        b[i] = 0;
        if (a[i] < -5) {
            b[i] = a[i] - 5;
        } else if (a[i] > 5) {
            b[i] = a[i] + 5;
        }
    }
}