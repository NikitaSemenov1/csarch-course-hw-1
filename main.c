#include <stdio.h>
#include <string.h>

void build_array(const int [], int [], size_t);
void input_array(FILE *, int [], size_t);
int validate_size(int);
int *alloc_array(size_t);
void free_array(int *);
void print_array(FILE *, int [], size_t);

int main(int argc, char* argv[]) {
    FILE *fin, *fout;

    if (argc == 1) {
        fprintf(stderr, "No parameters are provided\n");
        return 1;
    }

    if (!strcmp(argv[1], "-i")) {
        fin = stdin;
        fout = stdout;
    } else if (!strcmp(argv[1], "-f")) {
        if (argc < 4) {
            fprintf(stderr, "Input/output files are not provided\n");
            return 1;
        }
        fin = fopen(argv[2], "r");
        fout = fopen(argv[3], "w");
    } else {
        fprintf(stderr, "Invalid parameter");
        return 1;
    }

    int n;
    fscanf(fin, "%d", &n);

    if (validate_size(n)) {
        fprintf(fout, "Invalid size of the array");
        return 0;
    }

    size_t len = n;

    int *a = alloc_array(n), *b = alloc_array(len);

    input_array(fin, a, len);

    build_array(a, b, 5);

    print_array(fout, b, len);

    if (fin != stdin) {
        fclose(fin);
        fclose(fout);
    }
    
    free_array(a);
    free_array(b);

    return 0;
}