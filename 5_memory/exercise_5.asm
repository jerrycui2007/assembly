; Find the Maximum (Challenge)
; Declare an array: 33, 7, 92, 14, 58, 81, 3, 46. 
; Write a program that loops through the array and finds the maximum value. 
; Exit with the max as the exit code. Expect 92.

section .data
    array dq 33, 7, 92, 14, 58, 81, 3, 46

section .text
    global _start

_start:
    mov rax, [array]  ; initial maximum
    mov rbx, 1

    jmp compare

compare:
    cmp [array + rbx * 8], rax
    
    jg update

    jmp increment

update:
    mov rax, [array + rbx * 8]
    jmp increment

increment: 
    inc rbx
    cmp rbx, 7

    jp finish
    jmp compare

finish:
    mov rdi, rax
    mov rax, 60
    syscall
