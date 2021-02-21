[bits 16]

section .mbr
global _start
extern kernel_entry
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
_save_boot_device:
mov byte [boot_drive], dl ; store boot device in memory

; main boot loader code
_greeting:
mov al, byte [BGCol] ; background color goes in si
call _boot_functions.setBG ; set background color
mov si, greeting_message
call _boot_functions.print ; print contents of si, in this case, greeting message

_read_kernel: ; read kernel from disk and jump to it!
mov dl, byte [boot_drive] ; store boot device in dl
mov si, kernel_read_packet ; dap to tell the bios how to read the kernel
call _boot_functions.read_from_disk ; read kernel!
; here goes! Into the kernel
jmp kernel_entry

jmp error ; if control flow gets past the kernel jump

_boot_functions: ; used to perform standard operations, such as printing to the screen
int 0x19 ; reboot the machine if control flow reaches here
global _boot_functions.print ; for access from outside the mbr. Note that for outsiders, this is a boot
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
jmp _boot_functions._print_loop

global _boot_functions.setBG
.setBG: ; set the background color to what is stored in al
mov ah, 0x0B ; bios set background/border color
xor bh, bh ; bios function to set background/border color
mov bl, al ; background color is stored in al
int 0x10 ; bios call
ret

.read_from_disk: ; drive in dl, packet in ds:si
mov ah, 0x42 ; bios function to read using lba addressing
int 0x13 ; bios interrupt to perform disk i/o
jc error
ret

error: ; if an error occured
mov si, error_message
call _boot_functions.print ; print error message
hlt
jmp $ ; this stops the cpu by making it repeat the same instruction over and over again

global return
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
boot_drive db 0x00 ; reserved byte for the boot device number (set by the bios)
kernel_read_packet: ; lba packet to read 16bit kernel from disk
db 0x10 ; size = 0x10
db 0x00 ; random unused byte
dw 0x40 ; read 64 sectors (32kb)
dw 0x7E00 ; offset = 0x7E00
dw 0x0000 ; sector 0
dq 1 ; start at sector 1 (mbr is sector 0)

section .signature
db 0x55
db 0xaa