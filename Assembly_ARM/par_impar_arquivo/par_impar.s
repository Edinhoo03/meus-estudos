.global _start

    .section .data
        
        num:        .byte 8         @ Número a testar

        msg_impar:  .asciz "Impar\n"
        msg_par:    .asciz "Par\n"

    .section .text

        _start:
            ldr r1, =num
            ldrb r2, [r1]

            and r3, r2, #1
            cmp r3, #0
            beq eh_par
            b eh_impar

            mov r7, #1
            mov r0, #0
            svc #0


        eh_impar:
            mov r0, #1
            ldr r1, =msg_impar
            mov r2, #6

            mov r7, #4
            svc #0

            mov r7, #1
            mov r0, #0
            svc #0

        eh_par:
            mov r0, #1
            ldr r1, =msg_par
            mov r2, #4

            
            mov r7, #4
            svc #0

            mov r7, #1
            mov r0, #0
            svc #0



