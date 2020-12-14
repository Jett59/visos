printchar:
    ; before calling this function al must be set to the character to print;
	mov ah, 0x0E
    mov bh, 0x00 ;page to write to, page 0 is displayed by default;
	mov bl, 0x00
	
	int 0x10 ; int 0x10, 0x0E = print character in al
	ret

    printstr:
    ;before calling this function, edx must be set to the pointer to the string to print
    mov al, [si]
    push ax
    push si
    call printchar
    pop si
    pop ax
    inc si
    cmp al, 0x00
    jne printstr
    ret