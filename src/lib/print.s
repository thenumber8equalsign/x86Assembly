bits 64
default rel

section .text
    global println
    global printul
    global printl
    extern ultos
    extern ltos
println:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 16

    mov     byte [rbp-1], 0xa

    mov     rax, 1
    mov     rdi, 1
    lea     rsi, [rbp-1]
    mov     rdx, 1
    syscall

    mov     rsp, rbp
    pop     rbp
    ret
