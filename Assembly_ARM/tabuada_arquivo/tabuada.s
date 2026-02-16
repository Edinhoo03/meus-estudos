.global _start

    .section .data
        
        num_ini:    .byte 1         @ Número inicial do multiplicador
        num_lim:    .byte 10        @ Número limite do multiplicador
        
        num_alvo:   .byte 20         @ Número da tabuada (tabuada do 5)

    .section .text

        _start:
            ldr r1, =num_ini       @ r1 = endereço de num_ini
            ldrb r2, [r1]          @ r2 = 1 (multiplicador inicial)

            ldr r1, =num_lim       @ r1 = endereço de num_lim
            ldrb r3, [r1]          @ r3 = 10 (limite do multiplicador)

            ldr r1, =num_alvo      @ r1 = endereço de num_alvo
            ldrb r4, [r1]          @ r4 = 5 (número da tabuada)

        loop_inicio:
            push {r2-r4}           @ Salva contador, limite e alvo na pilha

            mul r5, r4, r2         @ r5 = r4 * r2 (ex: 5 * 1 = 5)
            mov r0, r5             @ r0 = resultado da multiplicação
            bl imprimir_numero     @ Chama função para imprimir o número

            pop {r2-r4}            @ Restaura contador, limite e alvo

            add r2, r2, #1         @ Incrementa multiplicador (r2 = r2 + 1)
            
            cmp r2, r3             @ Compara multiplicador com limite
            ble loop_inicio        @ Se r2 <= r3, volta pro loop

            mov r7, #1             @ syscall exit
            mov r0, #0             @ Código de retorno = 0 (sucesso)
            svc #0                 @ Executa exit

        imprimir_numero:

            push {r1-r7, lr}       @ Salva registradores e endereço de retorno

            mov r6, r0             @ r6 = cópia do número original
            cmp r6, #100           @ Compara com 100
            blt dois_digitos       @ Se menor que 100, pula para dois_digitos

        tres_digitos:
            sub sp, sp, #4         @ Reserva 4 bytes na pilha (buffer)
            mov r5, sp             @ r5 = ponteiro para o buffer

            @ Calcular centena
            mov r1, #100           @ Divisor = 100
            udiv r2, r6, r1        @ r2 = r6 / 100 (centena)
            mul r3, r2, r1         @ r3 = centena * 100
            sub r6, r6, r3         @ r6 = r6 - (centena*100) = resto

            @ Calcular dezena
            mov r1, #10            @ Divisor = 10
            udiv r3, r6, r1        @ r3 = r6 / 10 (dezena)
            mul r4, r3, r1         @ r4 = dezena * 10
            sub r4, r6, r4         @ r4 = r6 - (dezena*10) = unidade

            @ Converter para ASCII
            add r2, r2, #48        @ Converte centena para ASCII
            add r3, r3, #48        @ Converte dezena para ASCII
            add r4, r4, #48        @ Converte unidade para ASCII

            @ Guardar no buffer
            strb r2, [r5]          @ Guarda centena no buffer
            strb r3, [r5, #1]      @ Guarda dezena no buffer+1
            strb r4, [r5, #2]      @ Guarda unidade no buffer+2
            mov r2, #10            @ ASCII 10 = '\n'
            strb r2, [r5, #3]      @ Guarda quebra de linha no buffer+3

            @ Imprimir
            mov r0, #1             @ stdout (tela)
            mov r1, sp             @ Endereço do buffer
            mov r2, #4             @ Tamanho = 4 bytes
            mov r7, #4             @ syscall write
            svc #0                 @ Executa write

            add sp, sp, #4         @ Libera os 4 bytes da pilha
            b fim_imprimir         @ Pula para o fim

        dois_digitos:
            sub sp, sp, #3         @ Reserva 3 bytes na pilha (buffer)
            mov r5, sp             @ r5 = ponteiro para o buffer

            mov r1, #10            @ Divisor = 10
            udiv r2, r6, r1        @ r2 = r6 / 10 (dezena)
            mul r3, r2, r1         @ r3 = dezena * 10
            sub r3, r6, r3         @ r3 = r6 - (dezena*10) = unidade

            add r2, r2, #48        @ Converte dezena para ASCII ('0' = 48)
            add r3, r3, #48        @ Converte unidade para ASCII ('0' = 48)

            strb r2, [r5]          @ Guarda dezena no buffer
            strb r3, [r5, #1]      @ Guarda unidade no buffer+1
            mov r4, #10            @ ASCII 10 = '\n'
            strb r4, [r5, #2]      @ Guarda quebra de linha no buffer+2

            mov r0, #1             @ stdout (tela)
            mov r1, sp             @ Endereço do buffer
            mov r2, #3             @ Tamanho = 3 bytes
            mov r7, #4             @ syscall write
            svc #0                 @ Executa write

            add sp, sp, #3         @ Libera os 3 bytes da pilha

        fim_imprimir:
            pop {r1-r7, pc}        @ Restaura registradores e retorna