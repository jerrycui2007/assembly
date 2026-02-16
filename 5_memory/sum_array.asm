; Example of using memory to store an array and compute its sum
section .data
    numbers dq 1, 2, 3, 4, 5  ; store 5 qwords; numbers is the address of the first one
    count db 5

section .text
    global _start

_start:
    jmp add

add:
    add rax, [numbers + rbx * 8]
    inc rbx

    cmp [count], rbx

    jg add

    jmp finish

finish: 
    mov rdi, rax
    mov rax, 60
    syscall