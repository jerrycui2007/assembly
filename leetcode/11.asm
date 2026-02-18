; https://leetcode.com/problems/container-with-most-water/description/

section .bss
    height resq 100000  ; reserve 10^5 qwords, maximum length of the height array
    n resq 1

    input_buffer resb 64
    output_buffer resb 21

section .text
    global _start

_start:
    xor r8, r8  ; 0 for taking n input, 1 for taking heights input
    xor r9, r9  ; current index we are taking input for (for heights)

    jmp input  ; take n for input

input:
    mov rax, 0
    mov rdi, 0
    lea rsi, [input_buffer]
    mov rdx, 64
    syscall

    ; Set up for parsing
    mov rcx, rax
    lea rsi, [input_buffer]
    xor rax, rax
    xor rbx, rbx

    jmp parse_loop

parse_loop:
    cmp rcx, 0
    je parse_done

    mov bl, [rsi]
    cmp bl, 0x0A
    je parse_done

    sub bl, '0'
    imul rax, rax, 10
    add rax, rbx

    inc rsi
    dec rcx
    jmp parse_loop

parse_done:
    cmp r8, 1
    je store_height

    ; r8 == 0, so this is n
    mov [n], rax
    mov r8, 1
    jmp input

store_height:
    mov [height + r9 * 8], rax
    inc r9

    mov rbx, [n]
    cmp r9, rbx
    jge calculate
    jmp input

calculate:
    ; Actual calculations part of the program
    mov r10, 0  ; max area
    mov r11, 0  ; left pointer
    mov r12, [n]  ; right pointer
    sub r12, 1

    jmp while

while: 
    cmp r11, r12
    jge return

    mov r13, r12  ; temporary right-left
    sub r13, r11

    ; Get the shorter side
    mov r14, [height + r11 * 8]
    mov r15, [height + r12 * 8]

    cmp r14, r15

    jle min_left
    jg min_right

min_left: 
    jmp while_2

min_right:
    mov r14, r15
    jmp while_2

while_2:
    ; Get max of current max_area and the lower of the two heights
    mov rax, r14
    mul r13
    mov r14, rax
    cmp r10, r14

    jl update_max_area
    jmp while_3

update_max_area:
    mov r10, r14 
    jmp while_3

while_3:
    mov rdx, [height + r11 * 8]
    cmp rdx, [height + r12 * 8]
    jl inc_left
    jmp dec_right

inc_left:
    inc r11
    jmp while

dec_right:
    dec r12
    jmp while

return:
    ; Print the result
    lea rdi, [output_buffer + 20]
    mov byte [output_buffer + 20], 0x0A
    dec rdi
    mov rcx, 10
    mov rax, r10

output_loop:
    xor rdx, rdx
    div rcx

    add dl, '0'
    mov [rdi], dl
    dec rdi

    cmp rax, 0
    jg output_loop

    mov rsi, rdi
    lea rdx, [output_buffer + 21]
    sub rdx, rsi

    mov rax, 1
    mov rdi, 1
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall














