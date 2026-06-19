# x86Assembly
I Learned the best language ever, x86 Assembly, this is my first program.
<br>
Also, this is completely libc free. ZERO dependencies.

## Documentation so I dont forget
The ABI can be found at https://refspecs.linuxfoundation.org
<br><br>
The ISA can be found at https://www.intel.com/content/www/us/en/developer/articles/technical/intel-sdm.html
<br><br>
The AMD64 Architecture Programmer's Manual can be found at https://docs.amd.com/v/u/en-US/40332_4.09_APM_PUB

## other stuff so I don't forget
Never forget `lea`. Use `lea reg, [ptr+offset]` instead of `mov reg, ptr  add reg, offset`
assemble:
```bash
nasm -f elf64 file.s
```
link:
```bash
ld file.o -o main
```
link with libc/c runtime:
```bash
gcc file.o -fno-pie
```
or
```bash
ld file.o -o file -lc --dynamic-linker /lib64/ld-linux-x86-64.so.2
```
compile C code to object file:
```bash
gcc -c file.c
```
