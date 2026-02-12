; Examples of the mov command

section .data

section .text
    global _start

_start:
    mov rax, 0x000000001234567  ; load a value into rax
    
    mov rbx, rax  ; copy rax into rbx

    mov rcx, 0  ; zero out all of rcx
    mov ecx, 0xAABBCCDD  ; writes to the last 32 bits of rcx

    ;; Note: writing to a 32-bit register zeros out the first 32 bits, but writing to an 16/8-bit register does not zero out anything else

    mov rdx, 0
    mov dl, 0xFF  ;; the lowest 8 bits of rdx

    mov rax, 60
    mov rdi, 0
    syscall

; Debugging instructions
; nasm -f elf64 -g -o move_demo.o move_demo.asm   # -g adds debug symbols
; ld -o move_demo move_demo.o
; gdb ./move_demo

; Inside GDB, type these commands:

; break _start          # set a breakpoint at the start
; run                   # run the program (it stops at _start)
; layout asm            # show assembly view (optional, nice to have)
; stepi                 # execute ONE instruction
; info registers        # show ALL register values
