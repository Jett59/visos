org 0x7C00
bits 16

jmp start

%include "err.asm"
%include "stdio.asm"

start:
	mov ah, 0
	int 0x13
	jc printerr

	; draw text (will be overwritten by line)
	mov si, message
	call printstr
	ret

message db "Boot started"
db 0x0a
db 0x00

; Padding to 510 bytes with 0s
times 510-($-$$) db 0

; Master Boot Record Signature
db 0x55 ; byte 511 = 0x55
db 0xAA ; byte 512 = 0xAA
