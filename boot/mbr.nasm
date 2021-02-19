[bits 16]

section .mbr
global _start
_start:
; setup the segments
xor ax, ax
mov ds, ax
mov es, ax
_stack_setup: ; setup a new stack growing downwards from just below the mbr
cli ; clear interrupts which use the stack
mov ss, ax ; segment 0 of real mode memory
mov sp, 0x7C00 ; start address of mbr, stack grows downwards
sti ; re-enable interrupts now that the stack has been set up
call _greeting
_greeting:
mov si, BGCol ; background color goes in si
call _standard_functions.setBG ; set background color
mov si, greeting_message
call _standard_functions.print ; print contents of si, in this case, greeting message

hlt
jmp $

_standard_functions: ; used to perform standard operations, such as printing to the screen
int 0x19 ; reboot the machine if control flow reaches here
.print:
mov ah, 0x0e ; bios command to print to screen
xor bx, bx ; bh = page number, bl = color
._print_loop:
mov al, [si] ; store byte in al
cmp al, 0x00
je return
int 0x10 ; bios interrupt to print char stored in al
jc error ; call error in case of failier
inc si ; increment first parameter ready for next iteration
jmp _standard_functions._print_loop

.setBG:
mov ah, 0x0B ; bios set background/border color
xor bh, bh ; bios function to set background/border color
mov bl, byte [si] ; background color is stored in si
int 0x10 ; bios call
ret

error: ; if an error occured
mov si, error_message
call _standard_functions.print ; print error message
hlt
jmp $ ; this stops the cpu by making it repeat the same instruction over and over again

return:
ret ; pop last element off the stack and jump to it

section .mbrdata
error_message db "ERROR!"
db 0x0a
db 0x0d
db 0x00
greeting_message db "Welcome to ViSOS!"
db 0x0a
db 0x0d
db 0x00
BGCol db 0x01

section .signature
db 0x55
db 0xaa