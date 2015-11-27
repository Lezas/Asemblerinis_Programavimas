STEK SEGMENT STACK
        DB 256 DUP(?)
STEK ENDS       
                
DATA SEGMENT    
   PRAN DB 'Deivydas Pivorius II-21',13,10,13,10,'$'
      A DB ?,13,10,'$'              
      B DB ?,13,10,'$'
      C DB ?,13,10,'$'
      R DW ?
   FORM DB 'PROGRAMA SKAICIUOS KIEKVIENO STULPELIO BENDRA SUMA',13,10,'$'
    ATS DB 13,10,'ATSAKYMAS LYGYS $'
    LST DB 3 DUP(?),13,10,'$'
    IVA DB 'IVESKITE A EILUTE: $'
    IVB DB 13,10,'IVESKITE B EILUTE: $'
    IVC DB 13,10,'IVESKITE C EILUTE: $'
    IVD DB 13,10,'IVESKITE D EILUTE: $'
    IVE DB 13,10,'IVESKITE E EILUTE: $'
    IVF DB 13,10,'IVESKITE F EILUTE: $'
    DES DB 10
   DES1 DW 10
     DU DB 2      
KLAIDA1 DB 13,10,'IVYKO PERPILDYMAS IVEDANT SKAICIUS',13,10,'$'
KLAIDA2 DB 13,10,'IVYKO PERPILDYMAS ATIMANT SKAICIUS',13,10,'$'
KLAIDA3 DB 13,10,'IVYKO PERPILDYMAS DAUGINANT SKAICIUS',13,10,'$'
PROGPAB DB 13,10,'PROGRAMOS DARBO PABAIGA$'
DATA ENDS                                                  
                                                           
PROG SEGMENT                                               
        ASSUME DS: DATA, CS: PROG, SS: STEK                
START:                                                     
        JMP PRADZIA                                        
IVEDIMAS PROC                                              
                                                           
        MOV AH,08H                                         
        INT 21H                                            
                                                           
        MOV CL,'+'                                                                                                                
                                                           
        CMP AL,'-'                                
        JE PRENEIG
        JMP TEIG
SEK:           
        MOV AH,08H                                  
        INT 21H              
TEIG:          
        CMP AL,'0'
        JL SEK 
        CMP AL,'9'
        JG SEK        
               
        MOV DL,AL
        MOV AH,02H
        INT 21H      
               
        SUB AL,30H
        MOV BL,AL            
                                               
PLIUS:                                            
        MOV AH,08H                                
        INT 21H                                   
                                                  
        CMP AL,13                                 
        JE PAB                                      
                                                  
        CMP AL,'0'                                
        JL PLIUS                                  
        CMP AL,'9'                                
        JG PLIUS                                  
                                                  
        MOV DL,AL                                 
        MOV AH,02H                                
        INT 21H                                   
                                                  
        SUB AL,30H                                
        MOV BH,AL                                 
        MOV AL,BL              
        MUL DES               
        JO ERROR                     
        ADD AL,BH       
        JO ERROR              
        MOV BL,AL              
                               
        JMP PLIUS                                   
PRENEIG:         
        MOV DL,AL
        MOV AH,02H
        INT 21H                        
NEIG:                   
        MOV CL,'-'                
                        
        MOV AH,08H      
        INT 21H                   
                        
        CMP AL,'0'      
        JL NEIG         
        CMP AL,'9'           
        JG NEIG         
                        
        MOV DL,AL       
        MOV AH,02H      
        INT 21H         
                                     
        SUB AL,30H                                  
        MOV BL,AL 
        JMP PLIUS 
ERROR:            
        MOV AH,09H
        LEA DX,KLAIDA1
        INT 21H   
        JMP PABAIGA              
PREPAB:                 
        NEG BL          
        MOV CL,'+'                
PAB:                    
        CMP CL,'-'      
        JE PREPAB               
                        
        RET             
IVEDIMAS ENDP           
                        
PRADZIA:                
        MOV AX,DATA                  
        MOV DS,AX                                   
                        
        MOV AX,0002H    
        INT 10H         
                        
        MOV AH,09H      
        LEA DX,PRAN     
        INT 21H      
        LEA DX,FORM
        INT 21H   
        LEA DX,IVA      
        INT 21H              
        CALL IVEDIMAS
        MOV A,BL             
                     
        MOV AH,09H    
        LEA DX,IVB   
        INT 21H      
        CALL IVEDIMAS             
        MOV B,BL 
                                                    
        MOV AH,09H
        LEA DX,IVC
        INT 21H  
        CALL IVEDIMAS
        MOV C,BL  
                 
        MOV CL,00
        MOV AL,A 
        SUB AL,B 
        JO ERROR2
        CMP AL,0 
        JNL DAUG 
        NEG AL   
        INC CL   
DAUG:                 
        MOV A,AL      
        MOV AL,C      
        CMP AL,0      
        JNL DAUG2     
        NEG AL        
        INC CL        
DAUG2:                
        MUL DU   
        CMP AX,32000
        JE ERROR3            
        MUL A   
        CMP AX,32000        
        JE ERROR3     
        MOV R,AX      
                      
        MOV AH,09H    
        LEA DX,ATS    
        INT 21H       
                      
        CMP CX,1         
        JNE TOLIAU    
                      
        MOV DL,'-'    
        MOV AH,02H    
        INT 21H
        MOV AX,R       
        NEG AX        
TOLIAU:                  
        MOV CX,5      
        MOV DI,4      
        MOV AX,R      
CIKLAS:                 
        MOV DX,0000     
        DIV DES1      
        ADD DL,30H           
        MOV LST[DI],DL
        CMP AX,0
        JE GERAI
        DEC DI               
        LOOP CIKLAS                                             
GERAI:                      
        MOV AH,09H    
        LEA DX,LST[DI]
        INT 21H 
                   
        JMP PABAIGA         
ERROR2:          
        MOV AH,09H
        LEA DX,KLAIDA2
        INT 21H  
        JMP PABAIGA
ERROR3:          
        MOV AH,09H
        LEA DX,KLAIDA3
        INT 21H                        
PABAIGA:                                            
        MOV AH,09H                                  
        LEA DX,PROGPAB                              
        INT 21H                                     
                                                    
        MOV AH,07H                                  
        INT 21H         
        MOV AH,4CH      
        INT 21H         
PROG ENDS                  
END START