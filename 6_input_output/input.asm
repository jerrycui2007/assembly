; Example of taking input
section .bss
    input_buffer resb 64  ; reserve 64 bytes for the buffer
    output_buffer resb 21  ; 20 digits max for a 64-bit number + newline

section .text
    global _start

_start:
    ; Read input
    mov rax, 0  ; 0 is argument for read
    mov rdi, 0  ; descriptor; 0 = stdin
    lea rsi, [input_buffer]  ; load effective address, gets the address of buffer rather than the value (in this case it is same as mov)
    mov rdx, 64  ; max bytes to read
    syscall

    ; rax now holds the number of bytes read
    ; buffer now contains hex codes for each character (i.e 0x37 for 7, 0x0A for \n)
    mov rcx, rax  ; save byte count

    ; Convert ASCII into integer
    lea rsi, [input_buffer]  ; redundant but for best practices

    xor rax, rax  ; zero these for computations later, rax stores result
    xor rbx, rbx  ; rbx will store the current byte

parse_loop:
    cmp rcx, 0  ; check number of bytes left to read
    je parse_done

    mov bl, [rsi]  ; move one byte from the buffer in bl
    cmp bl, 0x0A  ; compare to newline character
    je parse_done

    sub bl, '0'  ; this gets the distance from '0' to the digit in ASCII, getting the actual number value

    imul rax, rax, 10  ; rax = rax * 10, shift over number by one decimal place by multiplying by 10
    add rax, rbx  ; add digit to one's place

    inc rsi  ; update counters
    dec rcx 
    jmp parse_loop

parse_done:
    ; Do whatever you want with the numbers

    ; Convert to ASCII for printing
    lea rdi, [output_buffer + 20]  ; point to end of buffer, because we extract digits by repeatedly dividing by 10 and taking the remainder, giving us digits in reverse order
    mov byte [rdi], 0x0A  ; place newline at the end
    dec rdi
    mov rcx, 10  ; divisor

next_digit:
    xor rdx, rdx  ; clear out rdx to store before doing division
    div rcx  ; rax = rax / rcx, rdx = rax % rcx

    add dl, '0'  ; get the ASCII code for the remainder (dl is last 8 bytes of rdx)
    mov [rdi], dl
    dec rdi 

    cmp rax, 0  ; check if our number is 0 yet
    jg next_digit

    inc rdi  ; before this, rdi pointed to one byte before the first digit

    ; Output
    mov rsi, rdi 
    lea rdx, [output_buffer + 21]  ; addres at the end of the buffer
    sub rdx, rsi  ; gets the length of the output

    mov rax, 1  ; sys_write
    mov rdi, 1  ; stdout
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall
