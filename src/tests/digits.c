#include <stdio.h>
#include <stdint.h>

extern uint64_t ldigits(int64_t, uint64_t);
extern uint64_t uldigits(uint64_t, uint64_t);

int main() {
    printf("Digits testing\n");
    printf("dec long -1 %lu\n", ldigits(-1, 10));
    printf("dec ulong -1 %lu\n", uldigits(-1, 10));
    printf("hex long -1 %lu\n", ldigits(-1, 16));
    printf("hex ulong -1 %lu\n", uldigits(-1, 16));
    printf("bin long -1 %lu\n", ldigits(-1, 2));
    printf("bin ulong -1 %lu\n", uldigits(-1, 2));
    printf("dec long -42 %lu\n", ldigits(-42, 10));
    printf("dec ulong -42 %lu\n", uldigits(-42, 10));
    printf("dec long 42 %lu\n", ldigits(42, 10));
    printf("dec ulong 42 %lu\n", uldigits(42, 10));
    return 0;
}
