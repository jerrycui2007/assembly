; Read and Write
; In .data, declare a qword named value initialized to 100. 
; In your program, load it into rax, add 50 to rax, then write the result back to the value memory location. 
; Then re-read value into rdi and exit. Verify with echo $? (expect 150).

section .data
    value dq 100

section .text
    global _start

_start:
    mov rax, [value]
    add rax, 50

    mov rdi, rax
    mov rax, 60
    syscall