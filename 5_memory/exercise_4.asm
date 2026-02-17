; Byte-Level Access
; Declare this in .data: my_val dq 0. 
; Then, using byte-sized mov instructions, write the value 0xEF to my_val, 0xBE to my_val + 1, 0xAD to my_val + 2, and 0xDE to my_val + 3. 
; Then read the full qword at my_val into rdi and exit. 
; Before you run it, predict what the 64-bit value will be by thinking about how the bytes are laid out in little-endian order. 
; (Hint: the exit code is mod 256, so use echo $? just to confirm it runs — the real exercise is predicting the hex value.)

section .data
    my_val dq 0

section .text
    global _start

_start:
    mov byte [my_val], 0xEF
    mov byte [my_val + 1], 0xBE
    mov byte [my_val + 2], 0xAD
    mov byte [my_val + 3], 0xDE

    mov rax, 60
    mov rdi, [my_val]
    syscall

    ; should produce 0xDEADBEEF = 239 (mod 256) in the exit code