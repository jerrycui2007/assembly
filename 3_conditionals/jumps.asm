; Example of jumps and labels in Assembly

section .data

section .text
    global _start

_start:  ;; this is a label (must start with letter or underscore)
    mov rax, 5
    jmp skip
    mov rax, 99

skip:
    mov rdi, rax  ;; return value is 5 because mov rax, 99 is never reached
    mov rax, 60
    syscall


