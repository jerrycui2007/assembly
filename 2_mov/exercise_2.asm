; Exercise 2 — Division and Remainders
; Write a program that computes 173 / 11. 
; Exit with the remainder as the exit code. 

section .data

section .text
    global _start

_start:
    mov rax, 173
    mov rbx, 11

    div rbx

    mov rax, 60
    mov rdi, rdx
    syscall