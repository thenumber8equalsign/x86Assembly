bits 64
default rel

section .rodata
    noargs:     db  "No arguments",0xa
    noargs_len: equ $-noargs
    nan:        db  "Not a number",0xa
    nan_len:    equ $-nan

section .text
    global _start
    extern printul
    extern stol
    extern stoul
    extern printl
    extern println
    extern isnumber
_start:
    mov     rdi, qword [rsp] ; argc

    cmp     rdi, 2
    jne     .noargs

    mov     rdi, qword [rsp+16] ; argv[1]

    xor     esi, esi
    call    isnumber

    test    rax, rax
    jz      .nan

    mov     rsi, 10
    call    stoul

    mul     rax ; square
    mov     rsi, 10
    mov     rdi, rax
    call    printul

    call    println

    mov     rax, 60
    mov     rdi, 0
    syscall

    hlt
.noargs:
    mov     rax, 1
    mov     rdi, 2
    lea     rsi, [noargs]
    mov     rdx, noargs_len
    syscall

    mov     rax, 60
    mov     rdi, 1
    syscall

    hlt
.nan:
    mov     rax, 1
    mov     rdi, 2
    lea     rsi, [nan]
    mov     rdx, nan_len
    syscall

    mov     rax, 60
    mov     rdi, 1
    syscall

    hlt
