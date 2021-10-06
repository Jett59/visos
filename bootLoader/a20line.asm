;check if the A20line is open
;if it is not, memory will loop at 1 mb and 1

checkA20line:
push es
push di
push ds,
push si
cli
;check whether the memory looped to es:di
xor ax, ax
mov es, ax
mov di, 0x0510
;memory location should loop from ds:si to es:di
mov ax, 0xffff
mov ds, ax
mov si, 0x0510


;try to change es:di using ds:si
mov byte[es:di], 0x00

;save byte at [es:di] on al
mov al, [es:di]

mov byte[ds:si], 0xff

;load new byte [es:di] into ah
mov ah, [es:di]

pop si
pop ds
pop di
pop es
;check that they are not the same
cmp al, ah
jne fail
je succeed

fail:
mov ax, 1
ret
succeed:
mov ax, 0
ret