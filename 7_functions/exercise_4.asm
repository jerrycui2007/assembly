; Write a recursive function factorial(n) that computes n!. 
; Base case: if rdi == 1, return 1. 
; Recursive case: save rdi (you'll need it after the recursive call returns), call factorial(rdi - 1), then multiply rax by the saved rdi. 
; Use rbx to save rdi across the recursive call (and remember to save/restore rbx in the prologue/epilogue). 
; Call factorial(5) from _start and exit with the result. Expected: 120.

section .text
    global _start 

; factorial: n -> n!
; Arguments: rdi = n
; Returns:   rax = n!
; Clobbers:  rax
factorial:
    push rbp
    mov rbp, rsp

    ; save rdi for later
    push rbx 
    mov rbx, rdi

    cmp rdi, 1
    jle return 
    jmp recurse

return: 
    mov rax, 1

    jmp epilogue

recurse:
    sub rdi, 1
    call factorial

    imul rax, rbx

    jmp epilogue

epilogue:
    pop rbx
    mov rsp, rbp
    pop rbp

    ret

_start:
    mov rdi, 5
    call factorial

    mov rdi, rax
    mov rax, 60
    syscall
