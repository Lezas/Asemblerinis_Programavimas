 
STEKAS SEGMENT STACK
   db 256 dup (0) ; baito dydzio duomenys DB - define Byte
STEKAS ENDS                                   
                                        
DUOMENYS SEGMENT
IVSR DB 25, 0, 25 DUP(' ') 
DU DB 2 
PRAN DB 'IVESKITE PAVARDE','$'      
DUOMENYS ENDS             
                                                       
PROGRAMA SEGMENT                                           
ASSUME CS:PROGRAMA, DS:DUOMENYS, SS:STEKAS 
START:                                       
MOV AX, DUOMENYS                                 
MOV DS, AX                
;pranesimas  
MOV AH, 09h
LEA DX, PRAN
INT 21H
;IVEDIMAS
MOV AH, 0Ah
LEA DX, IVSR
INT 21h
;$ GALE IVESTO TEKSTO
LEA DI, IVSR+2
MOV BL, IVSR+1
MOV BH, 0
ADD DI,BX ;ADRESAS KUR SIUSSIME $ ZENKLA
MOV BH, '$'
MOV [DI], BH  ;SPAUZDINIMO PABAIGA
; SKAICIUOJAM KUR SPAUZDINT
MOV AL, 80 ;KIEK STULPELIU
MOV AH, 0 
SUB AL, BL ;GALIM RASYT IR SUB AL, IVSR+1
DIV DU                  
MOV DL, AL    ; RANDAM KUR PRADET SPAUZDINT          
MOV DH, 13
MOV AH, 02    ;13 EILUTE                   
MOV BH, 00 ;PUSLAPIO NUMERIS
INT 10h  ;I PASKAICIUOTA VIETA PASTATOM ZYMEKLI SPAUZDINIMUI
;SPAUZDINIMAS
MOV AH, 09h
LEA DX, IVSR+2
INT 21h
;PABAIGA
MOV AH, 4ch
INT 21h
PROGRAMA ENDS
END START

                                                                
          
               
                      
         
   