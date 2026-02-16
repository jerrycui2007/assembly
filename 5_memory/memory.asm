section .data
    my_byte db 42         ; 1 byte
    my_word dw 1000       ; 2 bytes
    my_dword dd 70000     ; 4 bytes
    my_qword dq 123456789 ; 8 bytes
    ; These names (i.e. my_byte) are converted into addresses by the assembler

; Unitialized variables go into the .bss section
section .bss
    buffer  resb  64        ; reserve 64 bytes
    nums    resw  10        ; reserve 10 words
    big     resd  5         ; reserve 5 doublewords
    huge    resq  3         ; reserve 3 quadwords
    ; Guarenteed to be 0

; Using the .bss section when possible is better because putting it into .data would increase the size of the executable
; This memory is allocated at runtime

section .text
    global _start

_start:
    mov rax, my_qword  ; rax now holds the address of my_qword (e.g. 0x601000)
    mov rax, [my_qword]  ; rax now holds the value stored at my_qword (e.g. 123456789)

    mov rax, my_qword  ; this reads 8 bytes because rax is an 8-bit register
    ; Use the correct subregister for smaller data
    mov al, my_byte  ; put the 1-byte value in the 1-byte register
    
    mov rax, my_byte  ; the first byte will be correct, the rest will be 7 garbage bytes of whatever memory comes next
    mov [my_byte], al  ; do the same thing the other way around

    ; Storing immediate values
    ; mov [my_data], 42 causes an error, because how many bytes should 42 occupy?
    mov byte [my_data], 42  ; this works instead
