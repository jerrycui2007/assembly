; Example of call and ret in assembly
; Currently, the problem with jmp is that it doesn't know where to return to

; call <address> pushes the address of the next instruction onto the stack (next line)
; Then, it jumps to the given address

; ret pops the top of the stack onto rip, the instruction pointer

; When a function runs, it has its own scope, called the stack frame, pushed onto rsp
; rbp is the base pointer (frame pointer) for the frame, so you can refer to local variables with fixed offsets

section .text
    global _start

; add_two: rax, rsi -> rax
; Returns the sum of two numbers and stores the result in rax
; Clobbers: rax
add_two:
    push rbp  ; save existing variables
    mov rbp, rsp
    ; No local variables, so no need to sub rsp

    add rax, rsi

    mov rsp, rbp  ; restore rsp (discard local variables)
    pop rbp
    ret  ; go back to the instruction after the function was called

_start:
    mov rax, 10
    mov rsi, 20

    call add_two

    mov rdi, rax
    mov rax, 60
    syscall

