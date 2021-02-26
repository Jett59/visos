[bits 16]

section .text
global intcall
intcall: ; make a bios interrupt
; prepare yourself for some of the messiest code ever written

; int is equal to a pushf followed by a far call
push ds
; all of the general purpose registers are modified by this call, so push all of them
pusha
pushf ; push the flags
push cs ; store cs on the stack
call _prepare_interrupt
; interrupt will return to here after execution

; restore original state
popa
pop ds
ret ; finally leave this mess

_prepare_interrupt: ; push the segment and offset of the bios call onto the stack and use a retf to jump to it
shl ax, 2 ; multiply ax by 4 to get the address of the interrupt handler
mov bx, ax
xor ax, ax
mov ds, ax ; set ds to zero (segment for real mode interrupts)
push word [bx+4] ; push the segment pointed to by the bios interrupt entry
push word [bx] ; push the offset part
call _load_registers ; load all bios registers from memory. This will not effect the bios interrupt as we already pushed it to the stack
; this will 'return' to the bios call, which will return to the caller of this function
retf


_load_registers: ; load all of the registers from the interrupt registers table
mov ax, [interrupt_registers.ax]
mov bx, [interrupt_registers.bx]
mov cx, [interrupt_registers.cx]
mov dx, [interrupt_registers.dx]
ret

section .data
global interrupt_registers
interrupt_registers:
.ax:
.al db 0x00
.ah db 0x00
.bx:
.bl: db 0x00
.bh: db 0x00
.cx:
.cl: db 0x00
.ch db 0x00
.dx:
.dl db 0x00
.dh db 0x00
