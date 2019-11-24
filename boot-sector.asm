; Boot sector program that prints the words
; "Hello, World" and then loops forever.

; This directive explicitly states where in
; memory the boot sector will be loaded so
; that label references can be corrected.
[org 0x7c00]

mov bx, HELLO_MSG
call print_string

; Hang on an infinite loop once the message
; is printed to the screen.
jmp $

%include "print-string.asm"

HELLO_MSG:
    db 'Hello, World!', 0

; The boot sector program must be 512 bytes
; so add enough zero bytes as padding while
; leaving enough room for the magic number.
times  510-($-$$) db 0

; The last two bytes (one word) must be the
; magic number so that BIOS knows this is a
; boot sector.
dw 0xaa55