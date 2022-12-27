#include <stdio.h>
#include <stdint.h>

extern int32_t square(int32_t x);
extern void hello_from_rust();

int main(void) {
    hello_from_rust(); 
    printf("pow(5, 2) = %d\n", square(5));
    return 0;
}
