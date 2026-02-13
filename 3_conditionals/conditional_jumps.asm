; Examples of conditional jumps

; Instruction Meaning                  Flag Condition
; je          Jump if Equal            ZF = 1
; jne         Jump if Not Equal        ZF = 0
; jg          Jump if Greater (signed) ZF = 0 and SF = 0
; jl          Jump if Less (signed)    SF = 1
; jge         Jump if Greater or Equal SF = 0
; jle         Jump if Less or Equal    ZF = 1 or SF = 1

section .data

section .start
    global _start

_start:
    mov rax, 10
    cmp rax, 10

    je is_ten  ; if rax == 10, jump to is_ten

    ; Else
    mov rdi, 1
    jmp done  ; without jumping to the sys exit, the labels are ignored, so it would just keep executing lines (mov rdi, 0)

is_ten:
    mov rdi, 0
    jmp done

done:
    mov rax, 60
    syscall 


