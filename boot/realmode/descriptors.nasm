[bits 16]

section .text
load_gdt:
lgdt [eax]
retd
load_idt:
lidt [eax]
retd
