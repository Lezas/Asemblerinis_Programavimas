stekas SEGMENT STACK
DB 256 DUP (?)
stekas ENDS
duomenys SEGMENT
origp db '$', 'samaduailetsupokeksikisap'
tekstp db 10, 13, 26 DUP(0)            
duomenys ENDS                          
                                       
programa SEGMENT                       
ASSUME CS:programa, DS: duomenys, SS: stekas

START:
MOV AX, duomenys
MOV DS, AX
LEA SI, origp+26
MOV AH, '$'
LEA DI, tekstp+2
                  
PRAD: DEC SI      
CMP [SI], AH      
JE SPAU
MOV AL, [SI]
MOV [DI], AL
           
INC DI            
JMP PRAD
          
SPAU: MOV [DI], AH 
;spausdinimas
MOV AH, 09h
LEA DX, tekstp
INT 21h 

PABAIGA: MOV AH, 4ch
INT 21h

programa ENDS
END START


