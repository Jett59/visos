[bits 16]

section .mbrdata
db "World!"
db 0x00

section .mbr
global _boot
_boot:
hlt
db "Hello, "

section .signature
db 0x55
db 0xaa