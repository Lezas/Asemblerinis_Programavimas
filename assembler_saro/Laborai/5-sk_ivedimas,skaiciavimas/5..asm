stekas segment stack
        db 256 dup(?)
stekas ENDS         
                    
data segment
   pran db 'Agne Katkute II-2/1 ',10,13,13,13,10,'$'
                                                              
      a db 3 dup(?),13,10,'$'                       
      b db 3 dup(?),13,10,'$'                       
      c db 3 dup(?),13,10,'$'            
                    
    temp dw ?       
    uzd db 'Reiskinio (a*b+c) skaiciavimas',13,10,'$'
    ats db 13,10,'Rezultatas: $'
    lst db 6 DUP(?),13,10,'$'
    iva db 13,10,'Iveskite a: $'
    ivb db 13,10,'Iveskite b: $'
    ivc db 13,10,'Iveskite c: $'
    des db 10               
    desw dw 10              
                    
        klaida  db 13,10,'Ivyko perpildymas!',13,10,'$'
        progpab db 13,10,'PROGRAMOS DARBO PABAIGA$'
            
data ENDS           
                                                           
programa SEGMENT    
        ASSUME DS: data, CS: programa, SS: stekas
START:                                                     
        JMP pradzia
ivedimas PROC
       
        MOV AH,08h
        INT 21h                                          
               
        MOV CL,'+'                                                                                                                
                                                           
        CMP AL,'-'                                
        JE neigiamas
        JMP teigiamas
; Sekancio skaitmens ivedimas
sekantis:            
        MOV AH,08h
        INT 21h
teigiamas:                
        ;Simboliu tikrinimas                     
        CMP AL,'0'                   
        JL sekantis              
        CMP AL,'9'           
        JG sekantis               
                             
        MOV DL,AL            
        MOV AH,02h
        INT 21h
               
        ;Verciame i koda                             
        SUB AL,30h
        MOV BL,AL            
                                               
plius:                                            
        MOV AH,08h
        INT 21h   
                  
        ;Jei enter, baigiame ivedima
        CMP AL,13                                 
        JE pab
                                     
                                                  
        CMP AL,'0'                                
        JL PLIUS                                  
        CMP AL,'9'                                
        JG PLIUS                                  
                                                  
        MOV DL,AL                                 
        MOV AH,02H                                
        INT 21H                                   
              
        ;Verciame i koda                                          
        SUB AL,30H                                
        MOV BH,AL                                 
        MOV AL,BL              
        IMUL DES               
        JO ERROR                     
        ADD AL,BH            
        JO ERROR              
        MOV BL,AL              
                                     
        JMP PLIUS                                   
neigiamas:                     
        MOV DL,AL            
        MOV AH,02H           
        INT 21H                        
neig:
        MOV CL,'-'                
                             
        MOV AH,08H           
        INT 21H                   
                             
        CMP AL,'0'           
        JL neig              
        CMP AL,'9'           
        JG neig              
                             
        MOV DL,AL            
        MOV AH,02H           
        INT 21H              
                                     
        SUB AL,30H                                  
        MOV BL,AL            
        JMP plius
error:       
        MOV AH,09H           
        LEA DX,klaida
        INT 21H              
        JMP pabaiga
prepab:                      
        NEG BL               
        MOV CL,'+'                
pab:                         
        CMP CL,'-'           
        JE PREPAB               
                             
        RET                  
ivedimas ENDP
                             
pradzia:                     
        MOV AX,DATA                  
        MOV DS,AX                                   
                             
        MOV AX,0002H         
        INT 10H              
             
        ;Pranesimu spausdinimas                     
        MOV AH,09H             
        LEA DX,pran          
        INT 21H              
        ;Reiskinys
        LEA DX,UZD
        INT 21H   
             
        ;A ivedimas          
        LEA DX,IVA           
        INT 21H              
        CALL ivedimas        
        MOV a,BL             
                             
        ;B ivedimas                  
        MOV AH,09H           
        LEA DX,IVB           
        INT 21H              
        CALL ivedimas             
        MOV B,BL             
                                                    
        ;C ivedimas
        MOV AH,09H           
        LEA DX,IVC           
        INT 21H              
        CALL ivedimas        
        MOV C,BL             
               
;Skaiciavimas                             
             
        MOV CL,00
        MOV AL,a

        CMP AL,0 
        JNL n1
        NEG AL
        INC CL
n1:           
        MOV a,AL   
        MOV AH,00  
        MOV temp,AX  
        MOV AL,b   
        CMP AL,0   
        JNL n2
        NEG AL     
        INC CL     
                   
n2:
        IMUL temp  
        JO t2
        JMP n3
              
t2:           
        CMP AX,32700 
        JO ERROR3                    
n3:
        MOV BL,c
        CMP BL,0
        JG prid
        cmp cx,1
        je tol1 
        ADD AL,c
        JMP next
        tol1:
        SUB AL,c
        jmp next
        prid:
        cmp cx,1
        jne tol
        SUB AL,c
        jmp next
        tol:
        ADD AL,c
        next: 
        MOV temp,AX
        MOV AH,09H           
        LEA DX,ats
        INT 21H                                           
        CMP CX,1             
        JNE n4
        MOV DL,'-'           
        MOV AH,02H 
        INT 21H              
        NEG AL               
n4:            
        MOV CX,6             
        MOV DI,5             
        MOV AX,temp

 ciklas:           
        MOV DX,0000          
        IDIV desw            
        ADD DL,30H                   
        MOV LST[DI],DL       
        DEC DI               
        LOOP ciklas
                             
        MOV CX,2             
        MOV DI,0                    
ciklas2:                     
        CMP LST[DI],30H      
        JNE n5
        INC DI               
n5:
        LOOP ciklas2
                             
        MOV AH,09H           
        LEA DX,LST[DI]       
        INT 21H                                           
        JMP PABAIGA          
error2:
        MOV AH,09H                   
        LEA DX,klaida
        INT 21H              
        JMP PABAIGA          
error3:                      
        MOV AH,09H           
        LEA DX,klaida
        INT 21H                        

pabaiga:                                                                                                
        MOV AH,07H                                  
        INT 21H              
        MOV AH,4CH           
        INT 21H              
programa ENDS     
END START
