; Computes (10 + 20) * 3
section .data

section .text
    global _start

_start:
    mov rax, 10
    mov rbx, 20
    add rax, rbx

    mov rbx, 3
    mul rbx 

    mov rdi, rax  ; put the result as the exit code so we can see
    mov rax, 60
    syscall