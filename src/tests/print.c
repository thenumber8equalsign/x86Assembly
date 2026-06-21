#include <stdio.h>
#include <stdint.h>

extern void println();
extern void printul(uint64_t, uint64_t);
extern void printl(int64_t, uint64_t);

int main() {
    printul(64, 10);
    println();
    printul(64, 2);
    println();
    printul(64, 16);
    println();
    printul(10, 11);
    println();
    printul(-1, 10);
    println();
    printul(-1, 16);
    println();
    printul(-1, 2);
    println();

    puts("Signed -ve!");
    printl(-64, 10);
    println();
    printl(-64, 2);
    println();
    printl(-64, 16);
    println();
    printl(-10, 11);
    println();
    puts("Signed +ve!");
    printl(64, 10);
    println();
    printl(64, 2);
    println();
    printl(64, 16);
    println();
    printl(10, 11);
    println();
    return 0;
}
