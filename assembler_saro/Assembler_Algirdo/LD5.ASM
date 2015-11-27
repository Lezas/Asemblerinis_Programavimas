stekas segment stack
db 256 dup (?)
stekas ends

duomenys segment
a dw 240
b db 13
c db 7            
x dw 0 
duomenys ends        
                    
programa segment    
assume cs:programa, ds:duomenys, ss:stekas
start: mov ax, duomenys
        mov ds,ax
        mov ax,a
        mov bl,b
        mov bh,0
        mov cl,c
        mov ch,0
        add ax,bx
        sub ax,cx 
        mov x,ax
        mov ah,4ch
        int 21h 
                
 programa ends
 end start       