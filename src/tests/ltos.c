#include <stdio.h>
#include <stdint.h>

extern char* ultos(uint64_t, uint64_t);

int main() {
    printf("%s\n", ultos(64, 10));
    return 0;
}
