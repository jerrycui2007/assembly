; Write a function compute that does the following: 
; saves rbx on the stack (since you'll use it), 
; computes (rdi * rsi) + rdx using rbx as a temporary, 
; returns the result in rax, and restores rbx before returning. 
; Call it with arguments 3, 4, and 5 (expected result: 17). 
; Verify that rbx in _start is unchanged after the call by loading a sentinel value into rbx before calling and checking it afterward.

section .text
    global _start 

; compute:   a, b, c -> (a * b) + c
; Arguments: rdi = a, rsi = b, rdx = c
; Returns:   rax = (a * b) + c
; Clobbers:  rax
compute:
    push rbp
    mov rbp, rsp

    push rbx

    mov rbx, rdi
    imul rbx, rsi 
    add rbx, rdx

    mov rax, rbx 

    pop rbx
    pop rbp
    ret

_start:
    mov rbx, 67

    mov rdi, 3
    mov rsi, 4
    mov rdx, 5

    call compute 

    mov rdi, rax
    mov rax, 60
    syscall
    



