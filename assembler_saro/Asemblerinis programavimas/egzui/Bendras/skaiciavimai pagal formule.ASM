stekas segment stack
db 256 dup(?)
stekas ends 
duomenys segment 
salyga db 'Darba atliko: Vidas Razmislevicius II-3/6',10,13,'$'
a db 5                            
b db 6                            
c db 2                            
x db ?, 10, 13, '$'                                      
duomenys ends                            
program segment                         
assume cs:program, ds:duomenys, ss:stekas
start:                            
mov ax, duomenys                  
mov ds, ax                        
;                                 
mov ax, 02h                       
int 10h                           
;                                 
mov ah, 09h                       
lea dx, salyga                    
int 21h                           
;daugyba                          
mov al, a                         
mov bl, a                         
mul bl                            
;                                 
mov bl,al                         
;                                 
mov al, b        
mul b            
;                
add bl,al        
;                
mov x, bl        
mov al,x         
mov bl,3         
mul bl           
;                
        
mov bl, c        
mul bl           
;                
mov x, al        
;                
mov ah, 09h 
lea dx, x   
int 21h     
;           
mov ah, 07h 
int 21h     
;           
mov ah,4ch  
int 21h     
program ends
end start
        
        
        
        
                         
                                  
                                  
                                  
                                  
        
