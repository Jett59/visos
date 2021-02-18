[bits 16]

section .bootdata
db "World!"
db 0x00

section .boot
global _boot
_boot:
hlt
db "Hello, "

section .signature
db 0x55
db 0xAA