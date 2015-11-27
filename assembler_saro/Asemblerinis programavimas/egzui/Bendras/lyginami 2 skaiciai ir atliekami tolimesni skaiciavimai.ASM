stekas segment stack
db 256 dup(?)
stekas ends                       
duomenys segment
pran db 'Darba atliko : Vidas Razmislevicius II-3/6',10,13,'$'            
salyga db 'Salygu tikrinimas',10,13
db 'Atsakymas:',10,13, '$'          
x dw 2                             
y dw 2                             
a dw 4
b dw 0                             
f dw ? ,10,13,'$'                                     
duomenys ends                            
program segment                         
assume cs:program, ds:duomenys, ss:stekas
start:                             
mov ax, duomenys                   
mov ds, ax                         
mov ax, 02h                        
int 10h                                                 
;                                                          
;salygos                           
mov ax, a                                                   
cmp ax, b                          
je a_lygu_b                        
jl a_maz_b                         
jg a_daug_b                        
                                   
;                                  
a_lygu_b:                          
 mov ax, x                         
 add ax, y                                                       
 mov bx, 2                         
 imul bx                           
 jmp en                            
 a_daug_b:                         
 mov ax, x                         
 add ax, y                         
 mov bx, 2                         
 imul bx                           
 jmp en                            
 a_maz_b:                          
 mov ax, x                         
 add ax, y                         
 mov bx, -1                        
 imul bx                           
 mov bx, 2                         
 imul bx                           
 jmp en                            
en:                         
 add ax, 30h                 
mov f, ax
mov ah,09h
lea dx,pran
int 21h

mov ah, 09h                        
lea dx, salyga                     
int 21h     
                                     
                   
mov ah, 09h                        
lea dx, f                          
int 21h                     
                                  
mov ah, 07h                        
int 21h                              
                                                      
mov ah,4ch                         
int 21h                            
program ends                       
end start                          
                                   
                                   
                                   
                                   
                             
                                  
                                  
                                  
                                  
          
