section .data
    msg db 'Hello, World!', 10
    tam equ $ - msg

section .text
    global _start

    _start:

    mov rax, 1
    mov rdi, 1
    mov rsi, msg
    mov rdx, tam
    syscall
    mov rax, 60
    mov rdi, 0
    syscall