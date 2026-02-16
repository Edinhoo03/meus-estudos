# Guia Rápido - Assembly ARM

## 📦 Comandos de Compilação

```bash
# Compilar e executar (tudo em 1 linha)
arm-none-eabi-as -o programa.o programa.s && arm-none-eabi-ld -o programa programa.o && qemu-arm ./programa

# Passo a passo
arm-none-eabi-as -o programa.o programa.s    # Assembler: .s → .o
arm-none-eabi-ld -o programa programa.o      # Linker: .o → executável
qemu-arm ./programa                          # Executar no QEMU
```

---

## 🔢 Registradores ARM

| Registrador | Uso Comum |
|------------|-----------|
| `r0-r3` | Argumentos de função, valores temporários |
| `r4-r11` | Variáveis preservadas |
| `r7` | Número do syscall no Linux ARM |
| `r13 (sp)` | Stack Pointer (ponteiro da pilha) |
| `r14 (lr)` | Link Register (endereço de retorno) |
| `r15 (pc)` | Program Counter (próxima instrução) |

---

## 🛠️ Instruções Básicas

### Movimentação de Dados
```armasm
mov r0, #10         @ r0 = 10 (valor imediato)
mov r1, r0          @ r1 = r0 (copia registrador)
ldr r1, =var        @ r1 = endereço de 'var'
ldrb r2, [r1]       @ r2 = byte na posição r1 (load byte)
strb r3, [r1]       @ guarda byte de r3 na posição r1 (store byte)
```

### Aritmética
```armasm
add r0, r1, r2      @ r0 = r1 + r2
add r0, r1, #5      @ r0 = r1 + 5
sub r0, r1, r2      @ r0 = r1 - r2
mul r0, r1, r2      @ r0 = r1 * r2
udiv r0, r1, r2     @ r0 = r1 / r2 (divisão sem sinal)
```

### Lógica e Bits
```armasm
and r0, r1, r2      @ r0 = r1 & r2 (AND bit a bit)
orr r0, r1, r2      @ r0 = r1 | r2 (OR bit a bit)
eor r0, r1, r2      @ r0 = r1 ^ r2 (XOR bit a bit)
lsl r0, r1, #2      @ r0 = r1 << 2 (shift left)
lsr r0, r1, #2      @ r0 = r1 >> 2 (shift right)
```

### Comparação e Desvio
```armasm
cmp r0, r1          @ Compara r0 com r1 (afeta flags)
cmp r0, #10         @ Compara r0 com 10

b label             @ Pula incondicionalmente
beq label           @ Pula se igual (equal)
bne label           @ Pula se diferente (not equal)
blt label           @ Pula se menor (less than)
ble label           @ Pula se menor ou igual (less or equal)
bgt label           @ Pula se maior (greater than)
bge label           @ Pula se maior ou igual (greater or equal)
bl funcao           @ Chama função (branch with link)
```

### Pilha
```armasm
push {r0-r3}        @ Empilha r0, r1, r2, r3
pop {r0-r3}         @ Desempilha para r0, r1, r2, r3
push {r1-r7, lr}    @ Salva registradores + endereço de retorno
pop {r1-r7, pc}     @ Restaura registradores + retorna
```

---

## 🐧 Syscalls Linux ARM

Use `r7` para o número do syscall e `svc #0` para executar.

### Tabela de Syscalls

| Syscall | r7 | r0 | r1 | r2 | Descrição |
|---------|----|----|----|----|-----------|
| **exit** | `#1` | código retorno | - | - | Encerra programa |
| **read** | `#3` | file descriptor | buffer | tamanho | Lê dados |
| **write** | `#4` | file descriptor | buffer | tamanho | Escreve dados |
| **open** | `#5` | caminho | flags | modo | Abre arquivo |
| **close** | `#6` | file descriptor | - | - | Fecha arquivo |

### File Descriptors Padrão
- `0` = stdin (entrada padrão)
- `1` = stdout (saída padrão - tela)
- `2` = stderr (saída de erros)

---

## 📝 Exemplos Práticos

### Exit (encerrar programa)
```armasm
mov r7, #1          @ syscall exit
mov r0, #0          @ código de retorno = 0 (sucesso)
svc #0              @ executa syscall
```

### Write (imprimir string)
```armasm
.section .data
msg: .asciz "Hello\n"

.section .text
mov r0, #1          @ stdout
ldr r1, =msg        @ endereço da mensagem
mov r2, #6          @ tamanho (5 letras + \n)
mov r7, #4          @ syscall write
svc #0              @ executa
```

### Read (ler entrada)
```armasm
.section .bss
buffer: .space 10   @ reserva 10 bytes

.section .text
mov r0, #0          @ stdin
ldr r1, =buffer     @ endereço do buffer
mov r2, #10         @ tamanho máximo
mov r7, #3          @ syscall read
svc #0              @ executa (r0 retorna bytes lidos)
```

---

## 📂 Estrutura de um Programa

```armasm
.global _start

    .section .data
        @ Variáveis inicializadas
        num:    .byte 10
        msg:    .asciz "Texto\n"

    .section .bss
        @ Variáveis não inicializadas
        buffer: .space 20

    .section .text

        _start:
            @ Seu código aqui
            
            @ Exit
            mov r7, #1
            mov r0, #0
            svc #0

        minha_funcao:
            push {r1-r7, lr}    @ Salva registradores
            
            @ código da função
            
            pop {r1-r7, pc}     @ Restaura e retorna
```

---

## 💡 Dicas

1. **Push e Pop devem ser iguais**: `push {r2-r4}` → `pop {r2-r4}`
2. **Conversão para ASCII**: somar `#48` (ou `#'0'`)
   - Número `5` → ASCII `'5'` = `5 + 48 = 53`
3. **Tamanho de strings**: contar todos os caracteres incluindo `\n`
4. **Comentários**: use `@` para adicionar explicações
5. **Labels terminam com `:` (dois pontos)**
6. **Imediatos usam `#`**: `mov r0, #10` (não `mov r0, 10`)

---

## 🔍 Debugar Erros Comuns

| Erro | Causa | Solução |
|------|-------|---------|
| `Illegal instruction` | Programa não termina com exit | Adicionar exit no final |
| `unknown pseudo-op: .` | Espaço entre `.` e diretiva | `.global` (não `. global`) |
| `no such instruction` | Sintaxe errada | Verificar vírgulas e `#` |
| `internal_relocation` | Syscall errado | `mov r7, #4` (não `mov r7, 4`) |

---

## 📚 Projetos de Exemplo

- **Hello World**: Imprimir texto
- **Contador**: Loop de 1 a 10
- **Soma**: Somar dois números
- **Tabuada**: Multiplicação com loop
- **Par ou Ímpar**: Condicionais
- **Exponencial**: Loop aninhado (2^n)

---

**Criado para estudos de Assembly ARM (AArch32)**  
*Use este guia como referência rápida enquanto programa!* 🚀
