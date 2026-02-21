; Example of dynamically allocating memory at runtime

; The heap is where the dynamic memory lives. You can use syscalls to increase the size of the heap and get more memory

section .text:
    global _start

_start:
    ; brk (program break) is the address of the top edge of the heap
    ; You move it upwards to claim more memory

    mov rax, 12  ; code for sys_brk
    xor rdi, rdi  ; rdi = 0 means to return the current program break address
    syscall  ; rax now holds the current program break address

    mov rdi, rax
    add rdi, 800  ; request 800 more bytes
    move rax, 12
    syscall  ; rax is new break address

    mov rax, 60
    mov rdi, 0
    syscall