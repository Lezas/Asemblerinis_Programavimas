Stekas SEGMENT STACK
        DB 256 DUP(?)
        Stekas ENDS
        Duomenys SEGMENT
        a DB 65
        b DB 63
        x DB 0,'$'
        
        
        
        
        
        
        Duomenys ENDS
        Programa SEGMENT
                ASSUME SS:Stekas, DS:Duomenys, CS:Programa
                MOV AX, Duomenys
                MOV DS, AX
        START: MOV AH, a
               Add AH, b

               MOV X, AH
               MOV AH, 09h
               LEA DX, X
               INT 21h

               MOV AH, 02h
               INT 21h

               MOV AH, 4Ch
               INT 21h

               Programa ENDS
               END START
               
               
               
               
               , 