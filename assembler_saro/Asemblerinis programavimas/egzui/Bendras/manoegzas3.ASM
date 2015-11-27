stekas segment stack
db 256 dup (?)    
stekas ends       
duomenys segment  
atliko db 'pirmas musu darbas',13,10
db 'skaiciuosime a=5 b=2',13,10,'$' 
ats db 'a+b=','$'                   
a dw 5                              
b dw 2                              
c dw ?,'$'                          
duomenys ends                       
programa segment                    
assume cs:programa, ds:duomenys,ss:stekas
start:                              
mov ax,duomenys                     
mov ds,ax  ;butina                  
mov ax,02h                          
int 10h                             
                                    
mov ah,09h                          
lea dx,atliko                       
int 21h                             
mov ah,09h                          
lea dx,ats                          
int 21h                             
                                    
;pati programa                      
mov ax,a                            
add ax,b                            
add ax,30h                          
mov c,ax 

mov ah,09h
lea dx,c
int 21h                           
                                    
mov ah,07h                          
int 21h                             

mov ah,4ch
int 21h
programa ends
end start
  
  