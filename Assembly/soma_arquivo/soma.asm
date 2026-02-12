section .data
    n1 db 30
    n2 db 59
    resultado db 0

    num1_str db 0, 0
    num2_str db 0, 0
    res_str db 0, 0, 0

    output db 0, 0, ' + ', 0, 0, ' = ', 0, 0, 0, 10
    tam equ $ - output
    
section .text
    global _start

    _start:
    
    mov al, [n1]
    add al, [n2]
    mov [resultado], al

    mov cl, 10

    ;Armazena a unidade de unidade do Resultado
    xor ah, ah
    div cl
    add ah, 48
    mov [res_str + 2], ah

    ;Armazena a unidade de dezena do resultado
    xor ah, ah
    div cl
    add ah, 48
    mov [res_str + 1], ah

    ;Armazena a unidade de centena do resultado
    xor ah, ah
    div cl
    add ah, 48
    mov [res_str], ah

    ;Convertendo n1 para string
    mov al, [n1] ;carrega n1
    xor ah, ah  ;Zera AH
    div cl  ;n1 dividido por cl(10)
    add ah, 48 ;converte unidade para ASCII
    mov [num1_str + 1], ah  ;Armazena a unidade do n1

    ;Carrega as dezenas do n1
    xor ah, ah
    div cl
    add ah, 48
    mov [num1_str], ah  ;Armazena a dezena do n1


    ;converte n2 para string
    ;carrega as unidades de n2
    mov al, [n2]
    xor ah, ah
    div cl
    add ah, 48
    mov [num2_str + 1], ah

    ;carrega as dezenas de n2
    xor ah, ah
    div cl
    add ah, 48
    mov [num2_str], ah

    ;copiar num1_str para output
    mov al, [num1_str]
    mov [output], al
    mov al, [num1_str + 1]
    mov [output + 1], al

    ;copiar num2_str para output
    mov al, [num2_str]
    mov [output + 5], al
    mov al, [num2_str + 1]
    mov [output + 6], al

    ;copiar resultado para output
    mov al, [res_str]
    mov [output + 10], al
    mov al, [res_str + 1]
    mov [output + 11], al
    mov al, [res_str + 2]
    mov [output + 12], al

    ;printar o output
    mov rax, 1
    mov rdi, 1
    mov rsi, output
    mov rdx, tam
    syscall
    mov rax, 60
    mov rdi, 0
    syscall



