[bits 16]

section .text
global inb
inb: ; read a byte from the specified port
push dx
mov dx, ax
in al,dx
pop dx
retd

global outb
outb: ; write a byte to the port specified by the first argument
out dx,al
retd
