STEK SEGMENT STACK
        DB 256 DUP(?)
STEK ENDS       
                
DATA SEGMENT    
   PRAN DB 'ATLIKO GEDAS PETRAUSKAS IS II-22',13,10,13,10,'$'
      A DB ?,13,10,'$'              
      B DB ?,13,10,'$'
      C DB ?,13,10,'$'
    TMP DW ?  
   FORM DB 'PROGRAMA SKAICIUOS REISKINI (A-B)*2C',13,10,'$'
    ATS DB 13,10,'ATSAKYMAS LYGYS $'
    LST DB 6 DUP(?),13,10,'$'
    IVA DB 'IVESKITE A: $'
    IVB DB 13,10,'IVESKITE B: $'
    IVC DB 13,10,'IVESKITE C: $'
    DES DB 10
   DES2 DW 10  
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
        IMUL DES               
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
;        JO FAR ERROR2            
        CMP AL,0             
        JNL DAUG             
        NEG AL               
        INC CL               
DAUG:                        
        MOV A,AL  
        MOV AH,00  
        MOV TMP,AX           
        MOV AL,C                     
        CMP AL,0             
        JNL DAUG2            
        NEG AL               
        INC CL               
DAUG2:                       
        MOV AH,00                         
        IMUL DU              
        JO TIKR              
DAUG3:                       
        IMUL TMP               
        JO TIKR2              
        JMP TOLIAU1          
TIKR:                        
        CMP AX,32700           
        JG ERROR3            
        JMP DAUG3   
TIKR2:              
        CMP AX,32700 
        JO ERROR3        
TOLIAU1:                            
        MOV TMP,AX                                      
        MOV AH,09H           
        LEA DX,ATS           
        INT 21H                                           
        CMP CX,1             
        JNE TOLIAU                                        
        MOV DL,'-'           
        MOV AH,02H           
        INT 21H              
        NEG AL               
TOLIAU:                      
        MOV CX,6             
        MOV DI,5             
        MOV AX,TMP           
CIKLAS:                      
        MOV DX,0000          
        IDIV DES2            
        ADD DL,30H           
        MOV LST[DI],DL       
        DEC DI               
        LOOP CIKLAS          
                             
        MOV CX,2             
        MOV DI,0                    
CIKLAS2:                     
        CMP LST[DI],30H      
        JNE TOL              
        INC DI               
TOL:                         
        LOOP CIKLAS2                                           
                             
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