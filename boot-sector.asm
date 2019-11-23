; Boot sector program that loops forever.

; Define an infinate loop.
loop:
    jmp loop

; The boot sector program must be 512 bytes
; so add enough zero bytes as padding while
; leaving enough room for the magic number.
times  510-($-$$) db 0

; The last two bytes (one word) must be the
; magic number so that BIOS knows this is a
; boot sector.
dw 0xaa55