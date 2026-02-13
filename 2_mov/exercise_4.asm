; Exercise 5 — Swap Without Temporary Storage
; Put two different values into rax and rbx. 
; Swap them so rax has what rbx had and vice versa, using only add and sub (no mov, no third register).

section .data

section .text
    global _start

_start:
    mov rax, 1
    mov rbx, 2

    add rax, rbx
    sub rbx, rax
    neg rbx  ; negative keyword
    sub rax, rbx

    mov rdi, rax
    
    mov rax, 60
    syscall