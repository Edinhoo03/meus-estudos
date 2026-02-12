.global _start

    .section .data
    
        num1:   .byte 26
        num2:   .byte 44

        resultado:  .space 20

    .section .text
        
        _start:
            ldr r1, = num1      @ r1 = endereço de num1
            ldrb r2, [r1]       @ r2 = valor de num1 (23)
            ldr r1, = num2      @ r1 = endereço de num2
            ldrb r3, [r1]       @ r3 = valor de num2 (45)

            add r4, r2, r3      @ r4 = 23 + 45 = 68
            ldr r5, = resultado @ r5 = ponteiro do buffer (cursor)

            mov r0, r2          @ r0 = 23
            bl num_to_ascii     @ Converte para ASCII e guarda no buffer

            mov r0, #' '        @ Espaço
            strb r0, [r5], #1
            mov r0, #'+'        @ Sinal de mais
            strb r0, [r5], #1
            mov r0, #' '        @ Espaço
            strb r0, [r5], #1

            mov r0, r3          @ r0 = 45
            bl num_to_ascii     @ Converte para ASCII e guarda no buffer

            mov r0, #' '        @ Espaço
            strb r0, [r5], #1
            mov r0, #'='        @ Sinal de igual
            strb r0, [r5], #1
            mov r0, #' '        @ Espaço
            strb r0, [r5], #1

            mov r0, r4          @ r0 = 68 (resultado da soma)
            bl num_to_ascii     @ Converte para ASCII e guarda no buffer

            mov r0, #10         @ ASCII 10 = '\n'
            strb r0, [r5], #1   @ Guarda e avança

            ldr r1, = resultado @ r1 = início do buffer
            sub r2, r5, r1      @ r2 = tamanho (pos_final - pos_inicial)
            mov r0, #1          @ stdout (tela)
            mov r7, #4          @ syscall write
            svc #0              @ Executa write(1, resultado, tamanho)

            mov r7, #1          @ syscall exit
            mov r0, #0
            svc #0

        num_to_ascii:
            push {r1-r3, lr}    @ Salva registradores na pilha
            
            mov r1, #10         @ Divisor = 10
            udiv r2, r0, r1     @ r2 = r0 / 10 (dezena)
            mul r3, r2, r1      @ r3 = dezena * 10
            sub r3, r0, r3      @ r3 = r0 - (dezena*10) = unidade
            
            add r2, r2, #'0'    @ Converte dezena para ASCII ('0' + dezena)
            add r3, r3, #'0'    @ Converte unidade para ASCII ('0' + unidade)
            
            strb r2, [r5], #1   @ Guarda dezena e avança
            strb r3, [r5], #1   @ Guarda unidade e avança
            
            pop {r1-r3, pc}     @ Restaura registradores e retorna