; Exercise 3 — Multi-step Arithmetic
; Write a program that computes ((200 + 55) * 4) / 3 and exits with the quotient as the exit code. 
section .data

section .text
    global _start

_start:
    mov rax, 200
    add rax, 55
    mov rbx, 4
    mul rbx
    
    mov rbx, 3
    mov rdx, 0
    div rbx

    mov rdi, rax
    mov rax, 60
    syscall