[bits 16]

section .text
global _kernel_entry
extern _standard_functions.print
_kernel_entry:
mov si, message
call _standard_functions.print ; print message stored in si
hlt
jmp $

section .data
message db "Kernel successfully activated!"
db 0x0a
db 0x0d
db 0x00