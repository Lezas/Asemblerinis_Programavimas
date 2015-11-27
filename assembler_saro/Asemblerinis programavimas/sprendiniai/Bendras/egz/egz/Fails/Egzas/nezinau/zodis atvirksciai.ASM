stekas segment stack                   
       db 256 dup (0)                  
stekas ends                            
                                       
duomenys segment                       
a db 15                                
b db 10                                
c db 3                                 
x db ?                                 
                                       
vardas db 'Atliko Jaroslav Jakubovskij II-2/2' , 13,10
db 'pradinis zodis:'
pran db 'samaduailetsupokeksikisap',13,10, '$'
rezultatas db 25 dup(),13,10, '$'            
duomenys ends                          
                                       
programa segment                       
 assume cs:programa, ds:duomenys, ss:stekas
start:                                 
mov ax,0002h
int 10h

mov AX,duomenys                        
mov ds,ax                              
                                       
lea si,pran+24                         
lea di,rezultatas                      
mov cx,25                              
;ciklo formavimas                      
cik:                                   
mov ah,[si]                            
mov [di] ,ah                           
dec si                                 
inc di                                 
loop cik                               
                                       
mov ah,09h                             
LEA DX,vardas                          
int 21h                                
                                       
LEA dx,rezultatas                      
int 21h                                
;laukimas                              
;mov ah,07h                             
;int 21h                                
mov ah, 4ch                            
int 21h                                
programa ends                          
        end start            
                             
                             
                             
                             
        	             
 