; Reverse Three Values
; Put the values 1, 2, and 3 into r8, r9, and r10 respectively. 
; Using only push and pop (no mov between registers), rearrange them so that r8 = 3, r9 = 2, and r10 = 1. 
; Exit with r8 as the exit code (should show 3)

section .text
    global _start

_start:
    mov r8, 1
    mov r9, 2
    mov r10, 3

    push r8
    push r10

    pop r8
    pop r10

    mov rax, 60
    mov rdi, r8
    syscall