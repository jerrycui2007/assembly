; An alternative method of allocating memory: mmap

; Contract:
; sys_mmap = syscall number 9

; rdi = address hint (0 = let the kernel choose)
; rsi = length in bytes
; rdx = protection flags (read/write/execute)
; r10 = mapping flags
; r8  = file descriptor (-1 for anonymous/no file)
; r9  = offset (0 for anonymous)

; Returns: rax = address of mapped memory, or error

section .text
    global _start 

_start:
    ; Allocate 4096 bytes (one page) of read/write memory
    mov rax, 9              ; sys_mmap
    xor rdi, rdi            ; address = 0 (let kernel choose)
    mov rsi, 4096           ; length = 4096 bytes (always rounds up to next 4096 multiple anyways)
    mov rdx, 0x3            ; PROT_READ | PROT_WRITE
    mov r10, 0x22           ; MAP_PRIVATE | MAP_ANONYMOUS
    mov r8, -1              ; no file descriptor
    xor r9, r9              ; offset = 0
    syscall

    ; rax is now the address of your new 4096 bytes (or a negative number indicating error code)

    ; You can also free memory from mmap individually with munmap
    mov rdi, rax  ; address to unmap
    mov rsi, 4096 ; length
    mov rax, 11   ; sys_munmap
    syscall

    mov rax, 60
    mov rdi, 0
    syscall