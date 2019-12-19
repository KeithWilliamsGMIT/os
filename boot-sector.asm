; Boot sector program that prints a message
; to the screen before reading and printing
; data from the disk and looping forever.

[org 0x7c00]

mov bx, BOOTING_MESSAGE
call print_string

; Setup the stack.
mov bp, 0x8000
mov sp, bp

; BIOS will read the sectors to the segment
; es with an offset bx. Set the offset.
mov bx, 0x9000

; Select the number of sectors to read from
; the disk.
mov dh, 2

call disk_load

mov dx, [0x9000]
call print_hex

mov dx, [0x9000 + 512]
call print_hex

jmp $

%include "print-string.asm"
%include "print-hex.asm"
%include "disk.asm"

; Define a message that will be immediately
; printed to the screen on boot.
BOOTING_MESSAGE:
    db "Booting, please wait...", 0

; The boot sector program must be 512 bytes
; so add enough zero bytes as padding while
; leaving enough room for the magic number.
times 510-($-$$) db 0

; The last two bytes (one word) must be the
; magic number so that BIOS knows this is a
; boot sector.
dw 0xaa55

; Write two additional sectors of test data
; to the disk to check if we can read bytes
; from the disk. 
times 256 dw 0xdada
times 256 dw 0xface