; Functions for reading an int from stdin and printing an int
section .bss
    input_buffer resb 64
    output_buffer resb 22

section .text
    global _start 

; get_int:   void -> x
; Takes in an integer from stdin
; Arguments: None
; Returns:   rax = x
; Clobbers:  rcx, rdx, rsi, r8, r9, r11 (via syscall)
get_int:
    push rbp
    mov rbp, rsp

    lea rsi, [input_buffer]
    mov rdx, 64
    mov rax, 0
    mov rdi, 0
    syscall

    mov rcx, rax  ; byte count

    xor rax, rax
    xor r8, r8
    xor r9, r9  ; sign flag

    ; Check for leading '-'
    cmp byte [rsi], '-'
    jne .parse_loop

    mov r9, 1
    inc rsi
    dec rcx

.parse_loop:
    cmp rcx, 0
    jle .parse_done 

    mov r8b, [rsi]
    cmp r8b, 0x0A
    je .parse_done

    sub r8b, '0'

    imul rax, rax, 10
    add rax, r8

    inc rsi
    dec rcx

    jmp .parse_loop

.parse_done:
    cmp r9, 1
    je .neg

    mov rsp, rbp
    pop rbp

    ret

.neg:
    neg rax 

    mov rsp, rbp
    pop rbp

    ret

; print_int: int -> void
; Prints the integer in rdi to stdout
; Arguments: rdi = integer to print
; Returns:   None
; Clobbers,  rax, rcx, rdx, rdi, rsi, r11
print_int:
    push rbp
    mov rbp, rsp

    mov rax, rdi

    lea rdi, [output_buffer + 21]
    mov byte [rdi], 0x0a

    dec rdi
    mov rcx, 10

    cmp rax, 0

    xor r9, r9  ; sign flag
    jle .neg
    jmp .print_loop

.neg:
    mov r9, 1
    neg rax

.print_loop:
    xor rdx, rdx

    div rcx

    add dl, '0'
    mov [rdi], dl

    dec rdi

    cmp rax, 0
    jg .print_loop

    cmp r9, 1
    je .apply_neg
    jmp .print

.apply_neg:
    mov byte [rdi], 0x2d
    dec rdi

    jmp .print

.print:
    inc rdi

    mov rsi, rdi
    lea rdx, [output_buffer + 22]
    sub rdx, rsi

    mov rax, 1
    mov rdi, 1
    syscall

    mov rsp, rbp
    pop rbp

    ret

_start:
    call get_int

    mov rdi, rax

    call print_int

    mov rax, 60
    mov rdi, 0
    syscall


