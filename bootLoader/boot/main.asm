org 0x7C00
bits 16

jmp start

%include "err.asm"

printchar:
    ; before calling this function al must be set to the character to print;
	mov ah, 0x0E
    mov bh, 0x00 ;page to write to, page 0 is displayed by default;
	mov bl, 0x00
	
	int 0x10 ; int 0x10, 0x0E = print character in al
	ret

start:
	mov ah, 0
	int 0x13
	jc printerr

	; draw text (will be overwritten by line)
	mov al, 65
	alphabetloop call printchar
	inc al
	cmp al, 91
	jl alphabetloop
	ret

; Padding to 510 bytes with 0s
times 510-($-$$) db 0

; Master Boot Record Signature
db 0x55 ; byte 511 = 0x55
db 0xAA ; byte 512 = 0xAA
