; This file provides functionality to print
; a 0 terminated string stored in bx to the
; screen.

; Push the values of all the registers (ax,
; bx, cx and dx) to the stack. Then set the
; high byte of ax to the scrolling teletype
; BIOS routine for printing later.
print_string:
    pusha
    mov ah, 0x0e
    jmp print_next_letter

; Move the value currently in bx to the low
; byte of ax. If it is equal to 0 then jump
; to the end as it signifies the end of the
; string. Otherwise print the letter to the
; screen and store the next letter in bx by
; incrementing the memory address currently
; in bx. Repeat.
print_next_letter:
    mov al, [bx]
    cmp al, 0
    je end_print_string
    int 0x10

    add bx, 1
    jmp print_next_letter

; Finally, print both the newline character
; and carriage return character. To restore
; the original values of the registers, pop
; all their values off the stack. Return to
; the calling line.
end_print_string:
    mov al, 0x0a
    int 0x10

    mov al, 0x0d
    int 0x10

    popa
    ret