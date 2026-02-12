section .data
    num db 10

    lim db 1

    num_str db 0, 0, 10
    tam equ $ - num_str

section .text
    global _start

    _start:

        loop_in icio:
        mov al, [num]

        mov cl, 10
        xor ah, ah
        div cl
        add ah, 48
        mov [num_str + 1], ah

        xor ah, ah
        div cl
        add ah, 48
        mov [num_str], ah

        mov rax, 1
        mov rdi, 1
        mov rsi, num_str
        mov rdx, tam
        syscall

        mov al, [num]
        sub al, 1
        mov [num], al

        mov al, [num]
        cmp al, [lim]
        jge loop_inicio
    
    sair:
        mov rax, 60
        mov rdi, 0
        syscall
