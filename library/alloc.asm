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