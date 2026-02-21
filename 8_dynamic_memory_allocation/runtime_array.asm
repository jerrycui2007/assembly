; Example of using dynamic memory allocation to create a runtime-sized array
section .text
    global _start

_start:
    ; Get current program break
    mov rax, 12
    xor rdi, rdi
    syscall
    mov r12, rax  ; use r12 as the base of our allocated memory

    lea rdi, [rax + 40]  ; new break, 40 bytes after the old break
    mov rax, 12
    syscall

    ; Check if allocation succeded
    cmp rax, r12
    je .alloc_failed  ; if the addresses are the same, it didn't work

    ; Use the array
    mov qword [r12], 1
    mov qword [r12 + 8], 2
    mov qword [r12 + 16], 3
    mov qword [r12 + 24], 4
    mov qword [r12 + 32], 5

    mov rdi, [r12 + 32]
    mov rax, 60
    syscall

.alloc_failed:
    mov rdi, 1
    mov rax, 60
    syscall