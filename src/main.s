BITS 64
DEFAULT REL

section .data
    msg:        db  "Hello, World!",0xa
    msg_len:    equ $-msg

section .text
    global _start
_start:
    mov     rax, 1
    mov     rdi, 1
    lea     rsi, [msg]
    mov     rdx, msg_len
    syscall

    mov     rax, 60
    xor     edi, edi
    syscall
