STEKAS  segment STACK
        DB 256 DUP(?)
STEKAS  ENDS
            
DUOM    SEGMENT
        PRAN1   DB 'ATLIKO GEDAS PETRAUSKAS II-22',13,10,'$'
        PRAN2   DB 'REZULTATAS',13,10
                DB '(A+B-C)*2= $'
        PRAN3   DB 'PROGRAMOS DARBO PABAIGA',13,10,'$'
        PRAN4   DB 'REZULTATAS MAZESNIS UZ NULI',13,10,'$'
        PRAN5   DB 'REZULTATAS LYGUS NULIUI',13,10,'$'
        
        
        SPL DB 3 DUP(?) ,13,10,'$'                              
        A DB 40
        B DB 50 
        C DB 3        
        D DB 2
        E DB 10
                                      
DUOM    ENDS                                  
                                              
PROGRAM SEGMENT                               
        ASSUME  SS:STEKAS, DS:DUOM, CS:PROGRAM
                                      
START:  MOV AX,DUOM                   
        MOV DS,AX                     
       ;PROGRAMA                      
                                      
        MOV AH,00     
        MOV AL,A
        MOV BL,B
        MOV CL,C
        ADD AL,BL
        SUB AL,CL
        IMUL D 
               
        CMP AX,0
        JG REZ 
        JL PRN1
        JMP PRN2
               
    REZ:       
        DIV E  
        ADD AH,30H
        MOV SPL+2,AH
               
        MOV AH,00
               
        DIV E  
        ADD AH,30H
        MOV SPL+1,AH
               
        MOV AH,00
               
        DIV E  
        ADD AH,30H
        MOV SPL,AH
               
        MOV AH,09h                    
        LEA DX,PRAN2               
        INT 21h   
               
        MOV AH,09h                    
        LEA DX,SPL             
        INT 21h
               
        JMP PAB
               
   PRN1:       
        MOV AH,09h                    
        LEA DX,PRAN4                  
        INT 21h     
               
        JMP PAB
   PRN2:             
                               
        MOV AH,09h                    
        LEA DX,PRAN5                  
        INT 21h                       
   PAB:                               
        MOV AH,09h                    
        LEA DX,PRAN3   
        INT 21h                                           
        
        MOV AH,07H
        INT 21H                                                     
                                      
        MOV AH,4Ch    
        INT 21h      
                     
PROGRAM ENDS         
END START            
                     
        