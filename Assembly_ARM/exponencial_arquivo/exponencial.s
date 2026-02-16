.global _start

    .section .data

        num_ini:    .byte 1         @ Expoente inicial
        num_lim:    .byte 5         @ Expoente limite

        num_base:   .byte 2         @ Base da exponencial (2^n)


    .section .text

        _start:
        ldr r1, =num_ini       @ r1 = endereço de num_ini
        ldrb r2, [r1]          @ r2 = 1 (expoente inicial)

        ldr r1, =num_lim       @ r1 = endereço de num_lim
        ldrb r3, [r1]          @ r3 = 5 (expoente limite)

        ldr r1, =num_base      @ r1 = endereço de num_base
        ldrb r4, [r1]          @ r4 = 2 (base da exponencial)

    loop_inicio:
        push {r2-r4}           @ Salva expoente atual, limite e base na pilha

        mov r0, #1             @ r0 = 1 (resultado acumulado)
        mov r6, #0             @ r6 = 0 (contador interno)

    loop_potencia:
        mul r0, r0, r4         @ r0 = r0 * base (acumula multiplicação)
        add r6, r6, #1         @ Incrementa contador interno (r6 = r6 + 1)
        cmp r6, r2             @ Compara contador com expoente atual
        blt loop_potencia      @ Se r6 < r2, continua multiplicando

        push {r0}              @ Salva resultado na pilha
        bl imprimir_numero     @ Chama função para imprimir
        pop {r0}               @ Restaura resultado (não usado, mas mantém pilha)

        pop {r2-r4}            @ Restaura expoente, limite e base

        add r2, r2, #1         @ Incrementa expoente (r2 = r2 + 1)

        cmp r2, r3             @ Compara expoente com limite
        ble loop_inicio        @ Se r2 <= r3, volta pro loop

        mov r7, #1             @ syscall exit
        mov r0, #0             @ Código de retorno = 0 (sucesso)
        svc #0                 @ Executa exit

    imprimir_numero:
        
        push {r1-r7, lr}       @ Salva registradores e endereço de retorno
        
        sub sp, sp, #12        @ Reserva 12 bytes na pilha (buffer)
        mov r5, sp             @ r5 = início do buffer
        add r6, r5, #11        @ r6 = final do buffer (cursor)

        mov r1, #10            @ ASCII 10 = '\n'
        strb r1, [r6]          @ Guarda quebra de linha no final
        sub r6, r6, #1         @ r6-- (anda pra trás)

        mov r1, #10            @ Divisor = 10

    loop_digitos:
        
        udiv r2, r0, r1        @ r2 = r0 / 10 (quociente)
        mul r3, r2, r1         @ r3 = r2 * 10
        sub r3, r0, r3         @ r3 = r0 - (r2*10) = dígito (resto)

        add r3, r3, #48        @ Converte dígito para ASCII ('0' = 48)
        strb r3, [r6]          @ Guarda dígito no buffer
        sub r6, r6, #1         @ r6-- (anda mais pra trás)

        mov r0, r2             @ r0 = quociente (próxima iteração)
        cmp r0, #0             @ Se r0 > 0
        bgt loop_digitos       @ Continua extraindo dígitos

        add r6, r6, #1         @ r6++ (ajusta ponteiro pro primeiro dígito)
        sub r2, r5, r6         @ Calcula tamanho
        add r2, r2, #12        @ r2 = tamanho da string

        mov r0, #1             @ stdout (tela)
        mov r1, r6             @ Endereço do primeiro dígito
        mov r7, #4             @ syscall write
        svc #0                 @ Executa write

        add sp, sp, #12        @ Libera os 12 bytes da pilha
        pop {r1-r7, pc}        @ Restaura registradores e retorna
