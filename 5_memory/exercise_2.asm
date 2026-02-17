; Array Access
; Declare an array of 5 qwords: 5, 15, 25, 35, 45. 
; Without any loop, use direct addressing with displacement to load the third element (index 2) into rdi and exit. 
; Expect 25. Think carefully about the byte offset.

section .data
    array dq 5, 15, 25, 35, 45

section .text
    global _start

_start:
    mov rdi, [array + 2 * 8]
    
    mov rax, 60
    syscall