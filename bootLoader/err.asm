printerr:
	mov si, msg
	putloop

putloop:
        mov     al,[si]
        add     si,1            
        cmp     al,0
        je      fin
        mov     ah,0x0e         
        mov     bx,0       
        int     0x10           
        jmp     putloop

fin:
        hlt                     
        jmp     fin  

msg:
        db      0x0a, 0x0a      
        db      "error"
        db      0x0a            
        db      0
