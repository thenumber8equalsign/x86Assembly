#include <stdio.h>
#include <stdint.h>
extern uint64_t isnumber(const char*, uint64_t);

int main() {
    printf("%lu\n", isnumber("ff", 1));
    printf("%lu\n", isnumber("ff", 0));
    return 0;
}
