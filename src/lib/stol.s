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
    movzx   r9, byte [rdi+rcx]

    test    r9b, r9b
    jz      .done

    mul     rsi ; multiply by the base
    inc     rcx

    ; if greather than '9', its a letter
    cmp     r9b, "9"
    jg      .letter
    ; numerical digit path
    sub     r9b, "0"
    add     rax, r9
    jmp     .L3
.letter:
    sub     r9b, 87 ; subtract 97, then add 10
    add     rax, r9
    jmp     .L3
.done:
    ret

stol:
