; kalapastangan.asm
; Smooth char-by-char lyric typing

default rel
extern GetStdHandle
extern WriteFile
extern ExitProcess
extern Sleep

STDOUT equ -11

; -----------------------------
; DATA
; -----------------------------
section .data

; ---- lyrics ----
line1 db "Kalapastangan ang 'di ka ibigin", 0
line2 db "Kalokohan ang 'di ka isipin", 0
line3 db "Kung ang mundo ay biglang gugunawin", 0
line4 db "Ikaw ang", 0
line5 db "Una", 0
line6 db "kong", 0
line7 db "Hahanapin.", 0

newline db 13,10

; ---- typing delays (ms) ----
t_slow  dq 100
t_med   dq 80
t_fast  dq 50

; ---- line delays (ms) ----
l1 dq 1600
l2 dq 1000
l3 dq 1200
l4 dq 400
l5 dq 300
l6 dq 200
l7 dq 1500

section .bss
bytesWritten resq 1

; -----------------------------
; CODE
; -----------------------------
section .text
global main

main:
    ; stdout handle
    sub rsp, 40
    mov rcx, STDOUT
    call GetStdHandle
    add rsp, 40
    mov r12, rax

    ; -----------------------------
    lea rdx, [line1]
    mov r13, t_slow
    call type_line
    mov rcx, [l1]
    call sleep_ms

    lea rdx, [line2]
    mov r13, t_slow
    call type_line
    mov rcx, [l2]
    call sleep_ms

    lea rdx, [line3]
    mov r13, t_med
    call type_line
    mov rcx, [l3]
    call sleep_ms

    lea rdx, [line4]
    mov r13, t_fast
    call type_line
    mov rcx, [l4]
    call sleep_ms

    lea rdx, [line5]
    mov r13, t_fast
    call type_line
    mov rcx, [l5]
    call sleep_ms

    lea rdx, [line6]
    mov r13, t_fast
    call type_line
    mov rcx, [l6]
    call sleep_ms

    lea rdx, [line7]
    mov r13, t_slow
    call type_line
    mov rcx, [l7]
    call sleep_ms

    xor ecx, ecx
    call ExitProcess

; -----------------------------
; type_line
; rdx = string
; r13 = typing delay (ms)
; -----------------------------
type_line:
    mov rsi, rdx
.next:
    mov al, [rsi]
    test al, al
    jz .done

    call write_char
    mov rcx, [r13]
    call sleep_ms

    inc rsi
    jmp .next
.done:
    call newline_out
    ret

; -----------------------------
; write one character
; -----------------------------
write_char:
    sub rsp, 40
    mov rcx, r12
    lea rdx, [rsi]
    mov r8, 1
    lea r9, [bytesWritten]
    mov qword [rsp+32], 0
    call WriteFile
    add rsp, 40
    ret

; -----------------------------
; newline
; -----------------------------
newline_out:
    sub rsp, 40
    mov rcx, r12
    lea rdx, [newline]
    mov r8, 2
    lea r9, [bytesWritten]
    mov qword [rsp+32], 0
    call WriteFile
    add rsp, 40
    ret

; -----------------------------
; sleep helper
; -----------------------------
sleep_ms:
    sub rsp, 40
    call Sleep
    add rsp, 40
    ret
