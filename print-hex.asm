; Print the HEX value in the registry dx to
; the screen.

; Push all the registry values to the stack
; so that they can be restored when the HEX
; value is printed. Also, use cx to store a
; counter to four which can be used to loop
; through the HEX bytes.
print_hex:
    pusha
    mov cx, 4

; Loop over the counter in cx, decrementing
; the value by one on each pass. Copy dx to
; ax. Shift the value in dx four bits right
; for the next iteration. Then mask all but
; the last four bits in ax. The logical AND
; operator along with the HEX value 0xf, or
; 1111 in binary, can achieve this. HEX_OUT
; is moved to bx before skipping the prefix
; 0x and jumping to the position denoted by
; cx, which the HEX value will be copied to
; later. Compare ax to the HEX value 0xa to
; check if it represents a number or letter
; and do the following:
; 1. If it's greater than 0ax, indicating a
; letter, jump straight, to set_letter.
; 2. If it's less than 0ax, which indicates
; a number, then add 0x27 which in ASCII is
; the difference between "9" and "a" before
; jumping to set_letter.
loop_characters:
    dec cx

    mov ax, dx
    shr dx, 4
    and ax, 0xf

    mov bx, HEX_OUT
    add bx, 2
    add bx, cx

    cmp ax, 0xa
    jl set_letter
    add al, 0x27

    jl set_letter

; To bring the value in al to the HEX value
; of zero in the ASCII table add 0x30 to it
; before moving the value to the byte in bx
; denoted by the value of cx. Terminate the
; loop if cx is equal to zero. Otherwise go
; back and loop again. 
set_letter:
    add al, 0x30
    mov byte[bx], al

    cmp cx, 0
    je end_print_hex

    jmp loop_characters

; Print the HEX value pointed to by HEX_OUT
; to the screen before restoring all of the
; registry values and returning to the line
; where print_hex was called.
end_print_hex:
    mov bx, HEX_OUT
    call print_string
    popa
    ret

; Define a temporary variable which will be
; used to store the HEX value to be printed
; to the screen.
HEX_OUT:
    db "0x0000", 0