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
_read_kernel: ; read kernel from disk and jump to it!
mov dl, byte [boot_drive] ; store boot device in dl
mov si, kernel_read_packet ; dap to tell the bios how to read the kernel
call _boot_functions.read_from_disk ; read kernel!
; here goes! Into the kernel
jmp kernel_entry

jmp error ; if control flow gets past the kernel jump

_boot_functions:
int 0x19 ; reboot if control flow reaches here
.read_from_disk: ; drive in dl, packet in ds:si
mov ah, 0x42 ; bios function to read using lba addressing
int 0x13 ; bios interrupt to perform disk i/o
jc error
ret

error: ; if an error occured
int 0x19 ; reboot the machine

section .mbrdata
boot_drive db 0x00 ; reserved byte for the boot device number (set by the bios)
kernel_read_packet: ; lba packet to read 16bit kernel from disk
db 0x10 ; size = 0x10
db 0x00 ; random unused byte
dw 0x40 ; read 64 sectors (32kb)
dw 0x7E00 ; offset = 0x7E00 means that kernel will be read at 0x7E00
dw 0x0000 ; segment 0
dq 1 ; start at sector 1 (mbr is sector 0)

section .signature
db 0x55
db 0xaa