; Examples of arithmetic

section .data

section.text
    global _start

_start: 
    ; Addition/subtraction
    mov rax, 10
    add rax, 5  ; rax is now 15

    mov rbx, 3
    sub rax, rbx  ; rax is now 12

    inc rax  ; rax = rax + 1
    dec rax  ; rax = rax - 1

    ; Unsigned multiplication
    mul rbx  ; implicit operands, multiplies rax by rbx and store the result in rdx:rax
    ; result could be 128 bits
    ; if it fits in 64 bits, result is only rax and rdx will be 0

    mov rax, 7
    mov rbx, 6
    mul rbx  ; rdx = 0, rax = 42

    ; Unsigned division
    ; div rbx = divide the 128-bit value rdx:rax by rbx
    ; quotient is stored in rax
    ; remainder goes in rdx
    ; because we are dividing a 128-bit value, we have to clear rdx first

    mov rdx, 0
    mov rax, 42
    mov rbx, 5
    div rbx ; 42 / 5, rax = 8, rdx = 2

    
