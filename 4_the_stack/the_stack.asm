; The stack is a region of memory that is automatically setup when the program starts
; Data is stored in last-in, first-out structure
; The stack also grows downwards (goes from a high address to a low one)
; This is because the heap grows from the bottom, and this maximizes space

; rsp is the register that points to the top of the stack
; push subtracts 8 from rsp (since each stack slot is 8 bytes wide), and
; copies the value into the memory location rsp now points to
; pop is the reverse of push
; copies the value at the memory location into the destination register
; adds 8 to rsp

section .text
    global _start

_start:
    mov rax, 100
    mov rcx, 200  
    ; We want to keep these values later

    push rax
    push rcx

    ; Do some division
    mov ax, 8
    xor rdx, rdx  ; more efficient way of zeroing rdx
    mov r8, 2
    div r8  ; rax = 4, rdx = 0

    ; Restore original values
    pop rcx
    pop rax
    ; Both values are now as they were before

    ; Example of swapping two registers with the stack
    push rax
    mov rax, rcx
    pop rcx

    ; Direct stack access
    mov rax, [rsp]      ; read the value at the top of the stack (don't pop)
    mov rax, [rsp+8]    ; read the value ONE slot below the top
    mov [rsp], rbx      ; overwrite the top of the stack with rbx's value

    mov rax, 60
    xor rdi, rdi
    syscall

    
