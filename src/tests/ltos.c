#include <stdio.h>
#include <stdint.h>
#include <sys/mman.h>

extern char* ultos(uint64_t, uint64_t);
extern char* ltos(uint64_t, uint64_t);
extern uint64_t strlen(const char*);

int main() {
    char* s;
    s = ultos(64, 10);
    printf("%s\n", s);
    munmap(s, strlen(s)+1);

    s = ultos(0, 10);
    printf("%s\n", s);
    munmap(s, strlen(s)+1);

    s = ultos(-1, 16);
    printf("%s\n", s);
    munmap(s, strlen(s)+1);

    s = ltos(64, 10);
    printf("%s\n", s);
    munmap(s, strlen(s)+1);

    s = ltos(1, 16);
    printf("%s\n", s);
    munmap(s, strlen(s)+1);

    s = ltos(-64, 10);
    printf("%s\n", s);
    munmap(s, strlen(s)+1);

    s = ltos(0, 10);
    printf("%s\n", s);
    munmap(s, strlen(s)+1);

    s = ltos(-1, 16);
    printf("%s\n", s);
    munmap(s, strlen(s)+1);

    s = ltos(INT64_MIN, 16);
    printf("%s\n", s);
    munmap(s, strlen(s)+1);

    s = ltos(INT64_MIN, 10);
    printf("%s\n", s);
    munmap(s, strlen(s)+1);
    return 0;
}
