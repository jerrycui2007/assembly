; Array Modification
; Declare the same array: 5, 15, 25, 35, 45. 
; Write a program that doubles every element in place using a loop. 
; After the loop, load element index 3 into rdi and exit. Expect 70.

section .data
    array dq 5, 15, 25, 35, 45

section .text
    global _start

_start:
    xor rbx, rbx

    jmp double

double:
    mov rax, [array + rbx * 8]
    add [array + rbx * 8], rax
    inc rbx 

    cmp rbx, 4

    jle double

    mov rdi, [array + 3 * 8]
    mov rax, 60
    syscall