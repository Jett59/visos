org 0x7C00
bits 16

mov ah, 0
int 0x13

; draw text (will be overwritten by line)
mov al, 65
alphabetloop call printchar
inc al
cmp al, 90
jl alphabetloop

; set graphics mode
mov ah, 0
mov al, 0x13
int 0x10

; draw diagonal line
mov cx, 0
mov dx, 0
drawpixelloop call drawpixel
inc cx
inc dx
cmp cx, 100
jl drawpixelloop

drawpixel:
    ;before calling this function CX = x, DX = y must be set
	mov ah, 0x0C ;Write Pixel - https://en.wikipedia.org/wiki/INT_10H
    mov al, 0x0B ;Light Cyan - https://en.wikipedia.org/wiki/BIOS_color_attributes
    mov bh, 0x00 ;page to write to, page 0 is displayed by default
	
	int 0x10 ; int 0x10, 0x0C = draw pixel
	ret

printchar:
    ;before calling this function al must be set to the character to print
	mov ah, 0x0E
    mov bh, 0x00 ;page to write to, page 0 is displayed by default
	mov bl, 0x00
	
	int 0x10 ; int 0x10, 0x0E = print character in al
	ret


; Padding to 510 bytes with 0s
times 510-($-$$) db 0

; Master Boot Record Signature
db 0x55 ; byte 511 = 0x55
db 0xAA ; byte 512 = 0xAA
