; Explanation of some simple flags
section .data

section .text
    global _start

section _start:
    ; RLFAGS regiester is a 64-bit register, and each bit (called a flag) has a specific meaning
    ; When a flag's bit is 1, the flag is "set"
    ; What a flag's bit is 0, the flag is "cleared"

    ; Zero flag (ZF)
    ; Set when the result of an operation is 0
    mov rax, 10
    sub rax, 10  ; sets zero flag

    mov rax, 10
    sub rax, 5  ; clears zero flag

    ; Sign flag (SF)
    ; Set when the result of an operation is negative
    mov rax, 3
    sub rax, 7  ; sets sign flag

    mov rax, 7
    sub rax, 3  ; clears sign flag

    ; Carry flag (CF)
    ; Set when an operation produces a carry/borrow that doesn't fit in the register
    mov al, 255  ; lowest 8 bits of rax
    add al, 1  ; causes oveflow, sets carry flag

    ; The CPU updates these flags automatically, so no extra operations are needed

    ;; cmp instruction
    ;; Same as sub, but does not actually change the value of the registesr
    ;; Only flags are changed

    mov rax, 5
    mov rbx, 5
    cmp rax, rbx  ; sets ZF to 0

    mov rax, 60
    mov rdi, 0
    syscall