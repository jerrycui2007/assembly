; Write two functions: 
; square(n) which returns n * n, and 
; sum_of_squares(a, b) which returns square(a) + square(b). 
; sum_of_squares must call square twice. 
; Since sum_of_squares calls another function, it needs a proper prologue/epilogue and 
; must preserve the intermediate result of the first square call across the second call 
; (think carefully about where to store it — rbx is callee-saved, making it a good choice). 
; Call sum_of_squares(3, 4) from _start and exit with the result. Expected: 25.

section .text   
    global _start

; square:    n -> n ** 2
; Arguments: rdi = n
; Returns:   rax = n ** 2
; Clobbers:  rax
square:
    push rbp
    mov rbp, rsp

    mov rax, rdi
    imul rax, rdi

    pop rbp
    ret 

; sum_of_squares: a, b -> a ** 2 + b ** 2
; Arguments:      rdi = a, rsi = b
; Returns:        rax = a ** 2 + b ** 2
; Clobbers:       rax
sum_of_squares:
    push rbp
    mov rbp, rsp

    push rbx 

    call square 
    mov rbx, rax

    mov rdi, rsi
    call square 
    
    add rax, rbx

    pop rbx
    pop rbp

    ret

_start:
    mov rdi, 3
    mov rsi, 4
    
    call sum_of_squares

    mov rdi, rax
    mov rax, 60
    syscall

