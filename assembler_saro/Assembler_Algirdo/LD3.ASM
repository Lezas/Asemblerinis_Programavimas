stekas segment stack
db 256 dup (?)
stekas ends

duomenys segment
a db 240
b db 13
c db 10            
x db 0 
duomenys ends        
                    
programa segment    
assume cs:programa, ds:duomenys, ss:stekas
start: mov ax, duomenys
        mov ds,ax
        mov al,a
        mov bl,b
        mov cl,c
        add al,bl
        sub al,c
        mov x,al
        mov ah,4ch
        int 21h
        
 programa ends
 end start       