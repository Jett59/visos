org 0x7C00
bits 16
mov ah, 0
int 0x13
mov al, 1
mov bx, 0x8000
mov ch, 0
mov dh, 0
mov cl, 2
mov ah, 2
int 0x13
jmp 0x8000

; Padding to 510 bytes with 0s
times 510-($-$$) db 0

; Master Boot Record Signature
db 0x55 ; byte 511 = 0x55
db 0xAA ; byte 512 = 0xAA
