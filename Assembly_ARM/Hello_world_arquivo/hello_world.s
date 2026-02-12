.global _start
.section .data
mensagem:
    .ascii "Hello, World!\n"
    tam = . - mensagem

.section .text
    _start:

        mov r7, #4
        mov r0, #1
        ldr r1, =mensagem
        
        mov r2, #tam
        svc #0

        mov r7, #1
        mov r0, #0
        svc #0