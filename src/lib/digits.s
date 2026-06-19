BITS 64
DEFAULT REL

section .text
    global uldigits
    global ldigits
; uint64_t uldigits(uint64_t num, uint64_t base)
; note this DOES preserve rdi
uldigits:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 16 ; keep the stack aligned

    test    rdi, rdi
    jz      zero

    mov     qword [rbp-8], rdi
    mov     rax, rdi
    xor     edi, edi
.L3:
    xor     edx, edx
    div     rsi
    inc     rdi
    test    rax, rax
    jz      .uldigits_done
    jmp     .L3
.uldigits_done:
    mov     rax, rdi
    mov     rdi, qword [rbp-8]
    leave
    ret
; uint64_t ldigits(int64_t num, int64_t base)
ldigits:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 16

    test    rdi, rdi
    jns     .ldigits_positive
    jmp     .ldigits_negative
.ldigits_positive:
    call    uldigits
    leave
    ret
.ldigits_negative:
    neg     rdi
    call    uldigits
    neg     rdi ; restore the original rdi
    leave
    ret

zero:
    mov     rax, 1
    leave
    ret
