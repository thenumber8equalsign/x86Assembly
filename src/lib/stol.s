BITS 64
DEFAULT REL

section .text
    global stol
    global stoul
; uint64_t stoul(const char* str, uint64_t base)
; undefined behavior for base > 16 and for illegal characters (-ve sign is illegal in stoul)
; and for NaNs, like "\0", "-\0", etc
stoul:
    xor     ecx, ecx
    xor     eax, eax
.L3:
    movzx   rdx, byte [rdi+rcx]
    inc     rcx
    test    dl, dl
    jz      .done
    cmp     dl, "9"
    jg      .letter
    sub     dl, "0"
    add     rax, rdx
    mul     rsi
    jmp     .L3
.letter:
    sub     dl, 87
    add     rax, rdx
    mul     rsi
    jmp     .L3
.done:
    ret

stol:
