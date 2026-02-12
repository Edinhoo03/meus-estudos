.global _start

    .section .data
        
        num_ini:    .byte 20
        num_lim:    .byte 1
    
    .section .text

        _start:
            ldr r1, =num_ini        @ r1 = endereço de num_ini
            ldrb r2, [r1]           @ r2 = 10 (contador inicial)
            ldr r1, =num_lim        @ r1 = endereço de num_lim
            ldrb r3, [r1]           @ r3 = 1 (limite do loop)

        loop_inicio:
            push {r2, r3}           @ Salva contador e limite na pilha
            mov r0, r2              @ r0 = número a imprimir
            bl imprimir_numero      @ Chama função para imprimir
            pop {r2, r3}            @ Restaura contador e limite

            sub r2, r2, #1          @ Decrementa contador (r2 = r2 - 1)
            
            cmp r2, r3              @ Compara contador com limite
            bge loop_inicio         @ Se r2 >= r3, volta pro loop

            mov r7, #1              @ syscall exit
            mov r0, #0              @ Código de retorno = 0 (sucesso)
            svc #0                  @ Executa exit

        imprimir_numero:
            push {r1-r7, lr}        @ Salva registradores e endereço de retorno

            sub sp, sp, #3          @ Reserva 3 bytes na pilha (buffer)
            mov r5, sp              @ r5 = ponteiro para o buffer

            mov r1, #10             @ Divisor = 10
            udiv r2, r0, r1         @ r2 = r0 / 10 (dezena)
            mul r3, r2, r1          @ r3 = dezena * 10
            sub r3, r0, r3          @ r3 = r0 - (dezena*10) = unidade

            add r2, r2, #'0'        @ Converte dezena para ASCII
            add r3, r3, #'0'        @ Converte unidade para ASCII

            strb r2, [r5]           @ Guarda dezena no buffer
            strb r3, [r5, #1]       @ Guarda unidade no buffer+1
            mov r4, #10             @ ASCII 10 = '\n'
            strb r4, [r5, #2]       @ Guarda quebra de linha no buffer+2

            mov r0, #1              @ stdout (tela)
            mov r1, sp              @ Endereço do buffer
            mov r2, #3              @ Tamanho = 3 bytes
            mov r7, #4              @ syscall write
            svc #0                  @ Executa write

            add sp, sp, #3          @ Libera os 3 bytes da pilha
            pop {r1-r7, pc}         @ Restaura registradores e retorna
        



