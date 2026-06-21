bits 64
default rel

section .text
    global isnumber
; uint64_t isnumber(const char* s, uint64_t allowHex)
; uppercase letters get NaN even if allowHex is true
isnumber:
    xor     r8d, r8d
    mov     rax, 1
.L3:
    mov     dl, byte [rdi+r8]
    ; if r8 == 0 && dl == 0, nan cuz empty string
    test    r8, r8
    setz    cl
    test    dl, dl
    setz    ch
    and     cl, ch
    jnz     .nan
    ; otherwise if dl == 0 it means that r8 != 0 which means that the string is not empty
    test    dl, dl
    jz      .done

    test    rsi, rsi
    jnz     .hex

    cmp     dl, "0"
    jl      .nan
    cmp     dl, "9"
    jg      .nan
    inc     r8
    jmp     .L3
.hex:
    cmp     dl, "0"
    jl      .nan
    cmp     dl, "f"
    jg      .nan

    ; now we know that dl \in ["0","f"]
    cmp     dl, "9"
    jbe     .valid

    ; now dl \in ("9", "f"]
    cmp     dl, "a"
    jb      .nan ; if dl \in ("9", "a") then nan

.valid:
    inc     r8
    jmp     .L3
.nan:
    xor     eax, eax
.done:
    ret
