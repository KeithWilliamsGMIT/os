; Set up all the registers before using the
; BIOS read function. The registers purpose
; are as follows:
; ah - BIOS read sector function
; al - Number of sectors to read
; ch - Cylinder to read from
; dh - Head to read from
; cl - Sector to start reading from
; Use interrupt 0x013 to read data from the
; disk. If any errors occur print a message
; to the screen.
disk_load:
    push dx

    mov ah, 0x02
    mov al, dh
    mov ch, 0x00
    mov dh, 0x00
    mov cl, 0x02
    
    int 0x13

    jc disk_error

    pop dx
    cmp dh, al
    jne disk_error
    ret

; Print an error message to the screen when
; the carry flag is set while attempting to
; read the disk. Hang on an infinite loop.
disk_error:
    mov bx, DISK_ERROR_MSG
    call print_string    
    jmp $

; Define the error message to  print to the
; screen if the disk cannot be read.
DISK_ERROR_MSG:
    db "Disk read error!", 0