[bits 16]

section .text
global _kern16_putchar
_kern16_putchar: ; al = character to print
mov ah, [_screen.current_color] ; load current color into ah
mov si, [_screen.cursor_pos] ; save cursor position
add si, si ; double si to get the byte offset
mov word [es:si],ax ; write character to screen
mov si, [_screen.cursor_pos] ; put original cursor position in si
inc si ; increment cursor position
mov [_screen.cursor_pos], si ; write new cursor position to memory
ret

global _kern16_puts
_kern16_puts: ; put string stored in si onto the screen.
mov al, [ecx] ; read si iinto al
cmp al, 0x00
je return ; null terminator
push ecx ; function call destroys ecx
call _kern16_putchar ; put char stored in al onto the screen with ah being the attribute
pop ecx ; restore ecx
inc ecx ; increment si for the next iteration
jmp _kern16_puts ; repeat

global _kern16_cls
_kern16_cls: ; clear the screen
xor si, si ; segment = 0xB800, offset = 0
mov cx, 4000 ; 2000 bytes is the size of the text video memory. Two bytes per character
mov al, 0x00 ; set these bytes to zero
call _kern16_setmem ; clear the video memory
; reset the cursor position
mov byte [_screen.cursor_pos], 0x00 ; set cursor position to 0
ret

global _kern16_setmem
_kern16_setmem: ; set a portion of memory to a single value. Es:si is the start address, cx is the number of bytes to set, al is the source byte
mov byte [es:si], al ; set byte at es:si
inc si ; increment pointer
dec cx ; decrement counter
cmp cx, 0x0000
jg _kern16_setmem ; repeat if size is greater than zero
ret

global _kern16_functions.error ; fill the screen with red
.error:
    mov ax,0xb800
    mov es,ax     ;Set video segment to 0xb800
    mov ax,0x4020 ;colour + space character(0x20)
    mov cx,2000   ;Number of cells to update 80*25=2000
    xor di,di     ;Video offset starts at 0 (upper left of screen)
    rep stosw     ;Store AX to CX # of words starting at ES:[DI]

return:
ret

section .data
_screen:
.cursor_pos dw 0 ; cursor position
.stdout db 0x0A ; green
.stderr db 0x40 ; red
.current_color db 0x0A ; green
