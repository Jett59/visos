org 0x7C00
bits 16


jmp start

%include "stdio.asm"
%include "err.asm"

start:
xor ax, ax
mov ds, ax
mov es, ax
mov bx, 0x6e00
cli
mov ss, bx
mov sp, ax
sti
cld
	mov [drive], dl

	; draw text (will be overwritten by line)
	mov si, initial_message
	call printstr

mov dl, [drive]
mov bx, [loader_location]
mov al, 1
mov cl, 2
call readsectors
mov si, last_message
call printstr

xor si, si
jmp [loader_location]
	ret

loader_location dw 0x8000
drive db 0x00
initial_message db "Boot started"
db 0x0d
db 0x0a
db 0x00
last_message db "Jumping to kernel loader!"
db 0x0d
db 0x0a
db 0x00

; Padding to 510 bytes with 0s
times 510-($-$$) db 0

; Master Boot Record Signature
db 0x55 ; byte 511 = 0x55
db 0xAA ; byte 512 = 0xAA

;location of kernel loader