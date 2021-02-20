[bits 16]

section .text
global _kernel_entry
extern _boot_functions.setBG
_kernel_entry:
mov si, message
mov ah, byte [_screen.stdout] ; print to standard out
call _kern16_functions.puts ; print message stored in si
mov al, 65
mov ah, [_screen.stdout]
call _kern16_functions.putchar
jmp $
call _kern16_functions.cls ; clear the screen
xor si, si ; clear si
call _boot_functions.setBG ; set background color to black
hlt
jmp $

_kern16_functions: ; 16bit kernel functions
int 0x19 ; reboot if control flow reaches here
global _kern16_functions.putchar
.putchar: ; ah = either _screen.stdout or _screen.stderr, al = character to print
mov si, ds 
mov es, si ; store original ds in es
mov si, 0xB800 ; segment for text video ram
mov ds, si ; store address of video ram in ds
mov cx, [_screen.curser_pos] ; save curser position
add cx, cx ; double cx to get the byte offset of the next character
mov si, ax
mov [ds:si],ax ; write character to screen
mov si, [_screen.curser_pos] ; put original curser position in si
inc si ; increment curser position
mov [_screen.curser_pos], si ; write new curser position to memory
mov si, es
mov ds, si ; restore original ds
ret

global _kern16_functions.puts
.puts: ; put string stored in si onto the screen with attributes specified by ah (see _kern16_functions.putchar for more details)
mov al, [si] ; read si iinto al
cmp al, 0x00
je return ; null terminator
push si ; function call destroys si
call _kern16_functions.putchar ; put char stored in al onto the screen with ah being the attribute
pop si ; restore si
inc si ; increment si for the next iteration
jmp _kern16_functions.puts
ret

global _kern16_functions.cls
.cls: ; clear the screen
mov ax, ds
mov es, ax ; store original ds
mov ax, 0xB800
mov ds, ax ; 0xB8000 is the address of the text video memory
xor si, si ; segment = 0xB800, offset = 0
mov cx, 4000 ; 2000 bytes is the size of the text video memory. Two bytes per character
call _kern16_functions.clmem ; clear the video memory
mov ax, es
mov ds, ax ; restore original ds
ret

global _kern16_functions.clmem
.clmem: ; clear memory. ds:si stores the start address, cx stores the size of the memory
mov byte [ds:si], 0x00 ; clear byte at si
inc si ; increment pointer
dec cx ; decrement counter
cmp cx, 0x0000
jg _kern16_functions.clmem
ret

return:
ret

section .data
_screen:
.curser_pos dw 0 ; curser position
.stdout db 0x20 ; green
.stderr db 0x40 ; red
message db "Kernel successfully activated!"
db 0x0a
db 0x0d
db 0x00