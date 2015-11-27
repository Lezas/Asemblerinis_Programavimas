;funkcijos skaiciavimas x=(2a^2+b)/c
stekas segment stack                
db 256 dup(?)                       
stekas ends                         
                                    
duomenys segment                    
a db 2
b db 5                              
c db 6
pran db ,10,13,'Rezultatas: x= '       
d db ?
pr db '.'
g db ?,'$'
duomenys ends                       
                                    
programa segment                    
assume cs:programa, ds:duomenys, ss:stekas
start:                              
mov ax,duomenys                     
mov ds,ax                           

;ekrano valymas              
mov ax,0002h              
int 10h                
                                    
mov al,a                            
mul al                              
mul a                               
add al,b                            
div c                               
mov d,al
mov g,ah
                                    
add d,30h
add g,30h                           
mov ah,09h                          
lea dx,pran                         
int 21h                             
;laukia klaviso paspaudimo     
          mov ah, 07h                         
          int 21h              
;-grizhta i DOS                
                                                   
mov ah,4ch                          
int 21h                             
programa ends
end start