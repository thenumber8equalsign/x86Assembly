bits 64
default rel

section .rodata
er:     db  "Could not map memory for the string",0xa
er_len: equ $-er

section .text
    global println
    global printul
    global printl
    extern ultos
    extern ltos
; void println();
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
; void printul(uint64_t num, uint64_t base);
; recall ultos & ltos has UB for base > 16 || base < 2
printul:
    call    ultos ; convert to string, remember this returns the strlen in rdx
    test    rax, rax
    jz      failure

    push    rdx
    push    rax

    mov     rsi, rax
    mov     rdi, 1
    mov     rax, 1
    syscall ; rdx is already strlen()

    ; munmap(addr, ++len)
    pop     rdi ; addr in rdi
    pop     rsi ; strlen in rsi
    inc     rsi ; also free the null terminator
    mov     rax, 11
    syscall

    ret
; void printl(int64_t num, uint64_t base)
printl:
    call    ltos

    test    rax, rax
    jz      failure

    push    rdx
    push    rax

    mov     rsi, rax
    mov     rax, 1
    mov     rdi, 1
    syscall ; rdx is already the length of the string

    ; munmap(addr, ++len)
    pop     rdi
    pop     rsi
    inc     rsi
    mov     rax, 11
    syscall

    ret

failure:
    mov     rax, 1 ; write
    mov     rdi, 2 ; /dev/stderr /proc/self/fd/2
    lea     rsi, [er]
    mov     rdx, er_len
    syscall
    ret
