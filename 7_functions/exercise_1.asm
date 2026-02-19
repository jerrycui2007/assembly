; Write a function multiply that takes two arguments in rdi and rsi, multiplies them using imul, and returns the result in rax. 
; Call it from _start with the values 6 and 7, then exit with the result as the status code. 

section .text
    global _start

; multiply:  a, b -> a * b
; Arguments: rdi = a, rsi = b
; Returns:   rax = a * b
; Clobbers:  rax
multiply:
    push rbp
    mov rbp, rsp

    mov rax, rdi
    imul rax, rsi

    mov rsp, rbp
    pop rbp
    ret

_start:
    mov rdi, 6
    mov rsi, 7

    call multiply

    mov rdi, rax
    mov rax, 60
    syscall