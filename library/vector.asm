; Growable array (Python list, C++ vector, etc)

; Growable array state
; r12 = pointer to buffer
; r13 = count of elements currently stored
; r14 = capacity

section .text
    global _start

; alloc - int -> address
; Input:   rdi = number of bytes requested 
; Returns: rax = pointer to allocated memory, or -1 on failure
; Clobbers: caller-saved registers
alloc:
    push rbp
    mov rbp, rsp

    mov rsi, rdi            ; rsi = length (argument was in rdi)
    xor rdi, rdi            ; addr = 0 (kernel chooses)
    mov rdx, 0x3            ; PROT_READ | PROT_WRITE
    mov r10, 0x22           ; MAP_PRIVATE | MAP_ANONYMOUS
    mov r8, -1              ; no fd
    xor r9, r9              ; offset = 0
    mov rax, 9              ; sys_mmap
    syscall

    mov rsp, rbp
    pop rbp

    ret

; dealloc: address, int -> int
; Frees memory using munmap
; Arguments: rdi = address to free, rsi = # of bytes to free
; Returns: rax = 0 on success
dealloc:
    mov rax, 11
    syscall

    ret

_start:
    ; Initialize with room for 4 elements
    mov rdi, 32
    call alloc

    mov r12, rax  ; buffer pointer
    xor r13, r13
    mov r14, 4

    ; Push a value
    cmp r13, r14 
    cmp r13, r14  ; is the buffer full?
    jle .no_grow  ; regular insert

    ; Otherwise, double the current capacity
    shl r14, 1  ; shift r14's value to the left by 1 bit (equivalent to multiply by 2^1)
    mov rdi, r14
    shl rdi, 3  ; multiply by 8
    call alloc 
    mov r15, rax

    ; Copy data to the new buffer

.copy_loop:
    xor rcx, rcx  ; counter of elements copied
    cmp rcx, r13
    jge .copy_done

    mov rax, [r12 + rcx * 8]
    mov [r15 + rcx * 8], rax
    inc rcx 
    jmp .copy_loop

.copy_done:
    ; Free old buffer
    mov rdi, r12 
    mov rsi, r14
    shr rsi, 1  ; divide by 2^1
    shl rsi, 3  ; rsi = capacity of buffer / 2 (to get previous buffer size), then * 8 for byte size
    call dealloc

    mov r12, r15  ; finish swap

.no_grow:
    ; Regular insert
    mov qword [r12 + r13 * 8], 42
    inc r13

    mov rax, 60
    mov rdi, 0
    syscall