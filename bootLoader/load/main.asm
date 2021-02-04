org 0x8000
bits 16
jmp start
%include "a20line.asm"
%include "err.asm"
%include "stdio.asm"

start:
mov si, message
call printstr
call checkA20line
jc printerr
mov al, 65
call printchar
cmp ax, 0
jne enable_a20

typing_loop:
xor ah, ah
int 0x16
call printchar
cmp al, 0x0d
jne typing_loop
mov al, 0x0a
call printchar
jmp typing_loop
enable_a20:
mov si, a20_not_enabled_message
call printstr
jmp typing_loop
jmp $
hlt

message db "Loaded loader segment from disk!"
db 0x0d
db 0x0a
db 0x00
a20_not_enabled_message db "a20 line not already enabled"
db 0x0d
db 0x0a
db 0x00

times 512-($-$$) db 0 ;kernel must have size multiple of 512 so let's pad it to the correct size