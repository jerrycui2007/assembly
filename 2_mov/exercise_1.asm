; Exercise 1 — Register Windows
; Write a program that loads 0xAABBCCDDEEFF1122 into rax. 
; Then, using only mov instructions with sub-registers (eax, ax, ah, al), change rax to hold 0x00000000EEFF0042. 
; Do it step by step — reason about what each mov changes. Verify in GDB.
section .data

section .text
    global _start

_start:
    mov rax, 0xAABBCCDDEEFF1122

    mov eax, 0xEEFF0042  ; zeros out the first 32 bits as well
    
    mov rax, 60
    mov rdi, 0
    syscall
