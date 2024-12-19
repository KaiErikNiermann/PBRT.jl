// my_lib.c
#include <stdio.h>

typedef struct {
    int x;
    int y;
} point;

int get_x(point* p) {
    
}


int main() {
    point p = { 1, 2 };
    int* p_x = (int*)&p + 1;
    printf("p.x = %d\n", *p_x);
    return 0;
}
