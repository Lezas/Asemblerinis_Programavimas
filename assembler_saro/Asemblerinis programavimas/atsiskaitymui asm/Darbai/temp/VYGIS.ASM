STCK SEGMENT STACK           
DB 256 DUP (?)               
STCK ENDS                    
                             
DATA SEGMENT                 
A DB 9                       
B DB 5                       
C DB 1     
D DB 10                       
REZ DB 0,0, '$'                
DATA ENDS                    
                             
CODE SEGMENT                 
ASSUME CS:CODE, DS:DATA, SS:STCK
START:                       
MOV AX, DATA                 
MOV DS, AX                   
;CLEAR SCREEN                 
MOV AX, 0002H                
INT 10H                      
;SKAICIAVIMAS                             
MOV AH, 0                    
MOV AL, A                    
ADD AL, B                    
SUB AL, C  
DIV D                    
MOV REZ, AL
MOV REZ+1, AH                  
ADD REZ, 30H 
ADD REZ+1, 30H                
;PRINT MESSAGE               
MOV AH, 09H                  
LEA DX, REZ                  
INT 21H       
;PRESS ANY KEY               
MOV AH, 07H                  
INT 21H                      
;RETURN TO DOS, EXITS PROGRAM
MOV AH, 4CH   
INT 21H       
              
CODE ENDS     
END START     
