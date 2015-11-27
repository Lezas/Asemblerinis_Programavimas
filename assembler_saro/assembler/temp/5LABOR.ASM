Stekas SEGMENT STACK
                  
       DB 256 DUP (?)
                  
Stekas ENDS       
                  
Duomenys SEGMENT  
                  
         LIEKANA DB 10,13,'liekana '
         SPEL DB 3 DUP (0),'$'
         SVD DB 10,13,'sveikoji dalis '
         SPES DB 3 DUP (0),'$'
         DE DB 10
         A DB 15 
         B DB 13 
         C DB 5  
         DU DB 2 
         TRYS DB 3
         TARP DB 0
                  
Duomenys ENDS     
                  
Programa SEGMENT  
                  
         ASSUME CS:Programa,DS:Duomenys,SS:Stekas
                  
         START:   
         MOV AX,Duomenys
         MOV DS,AX
                  
         MOV AL,A
         ADD AL,B 
         SUB AL,C 
         MUL DU   
                  
         DIV TRYS 
                  
         MOV TARP,AH
                    
         LEA BX,SPES+2 
         MOV CX,3      
         CIK1:         
         MOV AH,0      
         DIV DE        
         ADD AH,30h    
         MOV [BX],AH   
         DEC BX        
         LOOP CIK1     
                       
         MOV AL,TARP   
                       
         LEA BX,SPEL+2 
         MOV CX,3      
         CIK2:         
         MOV AH,0      
         DIV DE        
         ADD AH,30h    
         MOV [BX],AH   
         DEC BX        
         LOOP CIK2     
                       
         MOV AH,09h    
         LEA DX,SVD    
         INT 21h       
         MOV AH,09h    
         LEA DX,LIEKANA
         INT 21h         
                       
         MOV AH,4Ch    
         INT 21h       
                       
Programa ENDS          
END START