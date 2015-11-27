STEKAS SEGMENT STACK   
        DB 255 DUP(?)  
STEKAS ENDS            
                       
DATA SEGMENT           
        PRAN DB 13,10,'Atliko Kestutis Normantas',13,10,'$'
     MASYVAS DB 5,40,7,15,23,123,29,13,'?'
       PRAN1 DB 'Suma: $'
        SUMA DB ?,13,10,'$'
       PRAN2 DB 'Vidurkis $'
         VID DB ?,13,10,'$'
     LIEKANA DB ?      
          KB DB ',$'   
       EL_SK DB 8      
      DESIMT DB 10     
         MAS DB 3 DUP(?),13,10,'$'
        LIEK DB 3 DUP(2),13,10,'$'      
DATA ENDS                         
                                  
PROG SEGMENT                      
        ASSUME SS: STEKAS, DS: DATA, CS: PROG
                                  
START:                            
        MOV AX,DATA               
        MOV DS,AX                 
                                  
        MOV AH,0002H              
        INT 10H                   
                                  
        MOV SI,0                  
        MOV AL,0                  
                                  
CIKL:                             
        CMP MASYVAS[SI],'?'       
        JE NEXT                   
        ADD AL,MASYVAS[SI]        
        INC SI                    
        LOOP CIKL                 
                                  
NEXT:                             
        MOV SUMA,AL               
        MOV CX,3                  
        MOV DI,2                  
                                  
CIKL2:                            
        MOV AH,00                 
        DIV DESIMT                 
        ADD AH,30H                
        MOV MAS[DI],AH 
        DEC DI                    
        LOOP CIKL2               
                       
                       
        MOV AH,09H     
        LEA DX,PRAN    
        INT 21H        
                       
        LEA DX,PRAN1   
        INT 21H        
                       
                       
                       
        LEA DX,MAS     
        INT 21H                   
                       
        MOV AL,SUMA    
        MOV AH,00      
        MOV DX,0000    
        DIV SI         
        MOV LIEKANA,DL 
        MOV VID,AL     
                       
        MOV DI,1       
        MOV CX,2       
 CIKL3:                
        MOV AH,00      
        DIV DESIMT     
        ADD AH,30H     
        MOV LIEK[DI],AH
        DEC DI         
        LOOP CIKL3     
                       
        MOV AH,09H     
        LEA DX,PRAN2
        INT 21H
        LEA DX,LIEK
        INT 21H
        LEA DX,KB
        INT 21H
        
        MOV AL,LIEKANA
        MOV DI,0
        MOV CX,2
        MOV DX,0000
CIKL4:
       MOV AH,00
       MUL DESIMT
       DIV SI
       ADD AL,30H
       MOV LIEK[DI],AL
       MOV AL,DL
       INC DI
       LOOP CIKL4
       
       MOV AH,09H
       LEA DX,LIEK
       INT 21H                
               
                                       
        MOV AH,4CH 
        INT 21H   
PROG ENDS         
END START