#include <stdio.h>
#include <stdint.h>

extern uint64_t strlen(const char* a);

int main() {
    char* s = "Hello, World!";
    printf("%lu\n", strlen(s));
    s = "1234567890";
    printf("%lu\n", strlen(s));
    s = "Nuh uh";
    printf("%lu\n", strlen(s));
    s = "dfsdf";
    printf("%lu\n", strlen(s));
    return 0;
}
