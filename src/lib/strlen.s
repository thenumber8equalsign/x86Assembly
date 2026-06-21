BITS 64
DEFAULT REL

section .text
    global strlen
; uint64_t strlen(const char* str)
; note this preserves everything except for rax
strlen:
    xor     eax, eax
.L3:
    cmp     byte [rdi+rax], 0
    je      .done
    inc     rax
    jmp     .L3
.done:
    ret
