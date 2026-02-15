; Stack Arithmetic (Challenge)
; Push the values 15, 25, and 10 onto the stack (in that order). 
; Then, without popping them into named registers, add all three values together into rax. 
; Clean up the stack by adding 24 to RSP (removing the three 8-byte slots manually). 
; Exit with the sum as the exit code (should show 50).

section .text
    global _start

_start:
    push 15
    push 25
    push 10

    add rax, [rsp]
    add rax, [rsp+8]
    add rax, [rsp+16]

    mov rdi, rax
    mov rax, 60
    syscall