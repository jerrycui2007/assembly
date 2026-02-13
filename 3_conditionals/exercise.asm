; Write a program that compares two numbers in rax and rbx. It should exit with:
; Exit code 0 if they are equal
; Exit code 1 if rax is greater
; Exit code 2 if rbx is greater

section .data

section .text 
    global _start

_start:
    mov rax, 67  ; num1
    mov rbx, 67  ; num2

    cmp rax, rbx

    je equal
    jl less  ; rax - rbx < 0, rax < rbx
    jg greater

equal:
    mov rdi, 0
    jmp done

less:  ; rax 
    mov rdi, 2
    jmp done

greater:
    mov rdi, 1
    jmp done

done:
    mov rax, 60
    syscall