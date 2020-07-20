
printerr:
	mov si, msg
	putloop

putloop:
        MOV     AL,[SI]
        ADD     SI,1            
        CMP     AL,0
        JE      fin
        MOV     AH,0x0e         
        MOV     BX,0       
        INT     0x10           
        JMP     putloop

fin:
        HLT                     
        JMP     fin  

msg:
        DB      0x0a, 0x0a      
        DB      "error"
        DB      0x0a            
        DB      0
