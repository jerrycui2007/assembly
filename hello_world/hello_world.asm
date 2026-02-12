section .data  ; section for initialized data at program start
    msg db "Hello World!", 10  ; msg is a label for the address storing this text, db = define bytes
    msg_len equ $ - msg  ; defines a constant called msg_len to be current address ($) - address of msg (msg)

section .text  ; code section
    global _start  ; _start is the default entry point for execution (linux equivalent of main in C)

_start: 
    mov rax, 1  ; start of system call, this is indicated by putting 1 (the syscall number) into rax
    mov rdi, 1  ; file descriptor (1 = stdout)
    mov rsi, msg  ; pointer to the object to write
    mov rdx, msg_len  ; number of bytes to write
    syscall  ; actually execute the syscall instruction

    ; Exit the program
    mov rax, 60  ; syscall 60 = sys_exit
    mov rdi, 0  ; exit code
    syscall