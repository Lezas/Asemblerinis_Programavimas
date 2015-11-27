STEKAS  segment STACK
        DB 256 DUP(?)
STEKAS  ENDS
            
DUOM    SEGMENT
        PRAN1   DB 'ATLIKO GEDAS PETRAUSKAS II-22',13,10
                DB 'REZULTATAI',13,10,'$'
        PRAN2   DB '((A*C)+B)/D=',13,10
                DB 'SVEIKOJI $'
                                      
        A DB 1        
        B DB 4        
        C DB 3        
        D DB 2        
        X DB ? ,13,10,'LIEKANA $'
        Y DB ? ,13,10,'$'
                                      
DUOM    ENDS                                  
                                              
PROGRAM SEGMENT                               
        ASSUME  SS:STEKAS, DS:DUOM, CS:PROGRAM
                                      
START:  MOV AX,DUOM                   
        MOV DS,AX                     
       ;PROGRAMA                      
                                      
        MOV AH,00     
        MOV AL,A      
        MUL C                      
        ADD AL,B      
        DIV D         
        ADD AL,30H                           
        MOV X,AL      
        ADD AH,30H                 
        MOV Y,AH                           
        MOV AH,09h                    
        LEA DX,PRAN1                  
        INT 21h                       
                                      
        MOV AH,09h                    
        LEA DX,PRAN2    
        INT 21h                       
                      
        MOV AH,09H    
        LEA DX,X      
        INT 21H          
                                      
        MOV AH,09h                    
        LEA DX,Y                  
        INT 21h                       
        
        MOV AH,07H
        INT 21H                                                     
                                      
        MOV AH,4Ch    
        INT 21h      
                     
PROGRAM ENDS         
END START            
                     
        