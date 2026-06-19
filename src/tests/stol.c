#include <stdio.h>
#include <stdint.h>
#include <sys/random.h>
#define true 1
#define false 0

extern uint64_t stoul(const char*, uint64_t);

int main() {
    printf("%lu\n", stoul("100", 10));
    printf("%lu\n", stoul("100", 2));
    printf("%lu\n", stoul("abcdef", 16));
    printf("%lu\n", stoul("a", 11));
    printf("%lu\n", stoul("ffffffffffffffff", 16));
    printf("%lu\n", stoul("42", 10));
    char str[17];
    _Bool pass = true;
    for (uint64_t i = 0; i < 500; ++i) {
        sprintf(str, "%lx", i);
        if (i != stoul(str, 16)) pass = false;
    }
    printf("%s\n", pass ? "pass" : "fail");

    pass = true;
    for (uint64_t i = 0; i < 1e6; ++i) {
        uint64_t r;
        getrandom(&r, 8, 0); // use /dev/urandom and blocking mode
        sprintf(str, "%lx", r);
        if (r != stoul(str, 16)) pass = false;
    }
    printf("%s\n", pass ? "pass" : "fail");

    pass = true;
    for (uint64_t i = 0; i < 1e6; ++i) {
        uint64_t r;
        getrandom(&r, 8, 0); // use /dev/urandom and blocking mode
        sprintf(str, "%lu", r);
        if (r != stoul(str, 10)) pass = false;
    }
    printf("%s\n", pass ? "pass" : "fail");

    return 0;
}
