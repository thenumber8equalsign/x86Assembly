bits 64
default rel

section .rodata
    digits: db  "0123456789abcdef",0xa

section .text
    global ltos
    global ultos
    extern uldigits
; undefined behavior for base > 16
; this also returns strlen(str) in rdx (assuming it succeeded)
; char* ultos(uint64_t num, uint64_t base)
ultos:
    ; find the number of digits in the number
    call    uldigits ; this preserves rdi and rsi
    inc     rax ; add 1 for null terminator
    push    rdi
    push    rsi
    push    rax
    ; mmap(NULL, len, 3, 34, 0, 0)
    mov     rsi, rax
    mov     rdi, 0
    mov     rdx, 3 ; PROT_READ|PROT_WRITE
    mov     r10, 34 ; MAP_ANON|MAP_PRIVATE
    mov     r8, 0
    mov     r9, 0
    mov     rax, 9
    syscall
    mov     rcx, rax

    pop     r8  ; length in r8
    dec     r8  ; this is now the index of the null terminator
    pop     rsi
    pop     rax ; put the number in rax for the div instruction

    cmp     rcx, -1
    je      .ultos_map_fail

    mov     byte [rcx+r8], 0
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
    ; r8 stores the index of the null terminator, which just so happens to be strlen()
    mov     rdx, r8
    dec     rdx
    mov     rax, rcx
    ret
.ultos_map_fail:
    xor     eax, eax
    ret

; char* ltos(uint64_t num, uint64_t base)
ltos:
    test    rdi, rdi
    jns     ultos   ; if rdi>=0, ultos(num, base)

    ; This section is nearly identical to ultos, with the sign
    ; find the number of digits in the number
    neg     rdi ; negate the number first
    call    uldigits ; this preserves rdi and rsi
    add     rax, 2 ; add 1 for the null terminator, add another 1 for the -ve sign

    push    rdi
    push    rsi
    push    rax
    ; mmap(NULL, len, 3, 34, 0, 0)
    mov     rsi, rax
    mov     rdi, 0
    mov     rdx, 3 ; PROT_READ|PROT_WRITE
    mov     r10, 34 ; MAP_ANON|MAP_PRIVATE
    mov     r8, 0
    mov     r9, 0
    mov     rax, 9
    syscall
    mov     rcx, rax

    pop     r8  ; length in r8
    dec     r8  ; this is now the index of the null terminator
    pop     rsi
    pop     rax ; put the number in rax for the div instruction

    cmp     rcx, -1
    je      .ltos_map_fail

    mov     byte [rcx+r8], 0
    mov     byte [rcx], "-"
    lea     r11, [digits] ; load the address of digits into r11 so that we can get some apple pie (get it haha funny)
    mov     r9, r8
.L4:
    dec     r9
    xor     edx, edx
    div     rsi ; divide by the base
    ; remainder in rdx
    mov     dl, byte [r11+rdx]
    ; dl is now the character to use
    mov     byte [rcx+r9], dl
    test    rax, rax
    jnz     .L4
.ltos_done:
    ; r8 stores the index of the null terminator, which just so happens to be strlen()
    mov     rdx, r8
    dec     rdx
    mov     rax, rcx
    ret
.ltos_map_fail:
    xor     eax, eax
    ret
