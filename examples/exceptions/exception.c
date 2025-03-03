#include <stdio.h>

typedef int (*int_function)(int, int);

int add_with_cb(int a, int b, int_function cb) {
    return cb(a, b);
}
