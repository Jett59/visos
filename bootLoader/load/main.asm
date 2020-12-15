org 0x8000
bits 16
jmp start
%include "err.asm"
%include "stdio.asm"
start:
mov si, message
call printstr
jmp $
hlt
ret

message db "Loaded loader segment from disk!"
db 0x0a
db 0x00

times 512-($-$$) db 0 ;kernel must have size multiple of 512 so let's pad it to the correct size