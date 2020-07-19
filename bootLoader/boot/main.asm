org 0x7C00
bits 16

mov ah, 0
int 0x13

mov al, 65
alphabetloop call printchar
inc al
cmp al, 90
jl alphabetloop

printchar:
		;before calling this function al must be set to the character to print
	mov bh, 0x00 ;page to write to, page 0 is displayed by default
	mov bl, al
	mov ah, 0x0E 
	int 0x10 ; int 0x10, 0x0E = print character in al
	ret


; Padding to 510 bytes with 0s
times 510-($-$$) db 0

; Master Boot Record Signature
db 0x55 ; byte 511 = 0x55
db 0xAA ; byte 512 = 0xAA
