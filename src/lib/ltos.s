bits 64
default rel

section .rodata
    digits: db  "0123456789abcdef",0xa

section .text
    global ltos
    global ultos
    extern uldigits
; undefined behavior for base > 16
; char* ultos(uint64_t num, uint64_t base)
ultos:
    ; find the number of digits in the number
    call uldigits ; this preserves rdi and rsi
    inc     rax ; add 1 for null terminator
    push    rdi
    push    rsi
    push    rax
    ; mmap(NULL, len, 3, 34, 0, 0)
    mov     rsi, rax
    mov     rdi, 0
    mov     rdx, 3
    mov     r10, 34
    mov     r8, 0
    mov     r9, 0
    mov     rax, 9
    syscall
    mov     rcx, rax

    pop     r8  ; length in r8
    dec     r8  ; this is now the index of the null terminator
    mov     byte [rcx+r8], 0
    pop     rsi
    pop     rax ; put the number in rax for the div instruction
    lea     r11, [digits] ; load the address of digits into r11 so that we can get some apple pie (get it haha funny)
    mov     r9, r8
.L3:
    dec     r9
    xor     edx, edx
    div     rsi ; divide by the base
    ; remainder in rdx
    mov     dl, byte [r11+rdx]
    ; dl is now the character to use
    mov     byte [rcx+r9], dl
    test    rax, rax
    jnz     .L3
.ultos_done:
    mov     rax, rcx
    ret
