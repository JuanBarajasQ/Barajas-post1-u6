; lab6_instrucciones.asm — Demostración de categorías de instrucciones x86
; Compilar: nasm -f bin lab6_instrucciones.asm -o lab6_instrucciones.com

org 100h ; offset de inicio para archivos .COM

; Datos:

jmp inicio ; saltar sobre los datos al código
valor_a dw 45 ; primer operando
valor_b dw 12 ; segundo operando
resultado dw 0 ; almacena resultado
contador db 5 ; contador de bucle
mascara db 0Fh ; máscara de 4 bits bajos

; Código:

inicio:
; BLOQUE 1: Transferencia de datos

 ; MOV: carga valor de memoria a registro
 MOV ax, [valor_a] ; AX = 45 (contenido de valor_a)
 MOV bx, [valor_b] ; BX = 12 (contenido de valor_b)

 ; MOV entre registros
 MOV cx, ax ; CX = AX = 45
 MOV dx, bx ; DX = BX = 12

 ; LEA: carga la dirección, no el contenido
 LEA si, [valor_a] ; SI = dirección de valor_a (no su valor)
 MOV ax, [si] ; AX = mem[SI] = 45 (indirecto vía SI)

 ; XCHG: intercambio de registros
 XCHG cx, dx ; CX=12, DX=45
 XCHG cx, dx ; restaurar: CX=45, DX=12

 ; PUSH/POP: preservar y restaurar
 PUSH ax ; guarda AX=45 en pila
 MOV ax, 0FFFFh ; modifica AX temporalmente
 POP ax ; restaura AX=45
