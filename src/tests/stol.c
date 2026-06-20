#include <stdio.h>
#include <stdint.h>
#include <sys/random.h>
#define true 1
#define false 0

extern uint64_t stoul(const char*, uint64_t);
extern uint64_t stol(const char*, uint64_t);

int main() {
    printf("%lu\n", stoul("100", 10));
    printf("%lu\n", stoul("100", 2));
    printf("%lu\n", stoul("abcdef", 16));
    printf("%lu\n", stoul("a", 11));
    printf("%lu\n", stoul("ffffffffffffffff", 16));
    printf("%lu\n", stoul("42", 10));
    char str[18];
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

    printf("%lu\n", stoul("~", 40)); // it works
    printf("%lu\n", stoul("z", 40));

    printf("Signed!\n");
    printf("%ld\n", stol("-100", 10));
    printf("%ld\n", stol("-100", 2));
    printf("%ld\n", stol("-abcdef", 16));
    printf("%ld\n", stol("-a", 11));
    printf("%ld\n", stol("-8000000000000000", 16));
    printf("%ld\n", stol("-ffffffffffffffff", 16));
    printf("%ld\n", stol("-42", 10));

    pass = true;
    for (uint64_t i = 0; i < 10; ++i) {
        uint64_t r;
        getrandom(&r, 8, 0); // use /dev/urandom and blocking mode
        sprintf(str, "%ld", r);
        if ((long)r != stol(str, 10)) pass = false;
    }
    printf("%s\n", pass ? "pass" : "fail");

    printf("%ld\n", stol("-~", 40)); // it works
    printf("%ld\n", stol("-z", 40));

    return 0;
}
