[bits 16]

global protected_mode_jump
protected_mode_jump: ; actual transition into protected mode!
mov edx, cr0
or dl, 1 ; set pe bit
mov cr0, edx ; apply changes
; the big jump
jmp 0x08:initialise_protected_mode

 [bits 32]

extern screen

initialise_protected_mode: ; arrive here after cpu is switched into protected mode
mov edx, 0x10 ; offset into the gdt of the data segment
mov ds, edx
mov es, edx
mov fs, edx
mov gs, edx ; all segment registers except ss are now loaded with the data segment

mov ss, edx
mov esp, 0x00FFFFF0 ; All of that sweet memory!

xor eax, eax ; clear all of the general purpose registers
mov edx, eax
mov ecx, eax
mov esi, eax
mov edi, eax

; just hlt for now
hlt:
hlt
jmp hlt