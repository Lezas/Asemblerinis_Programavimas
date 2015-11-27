; -----formule: X=2a+bc
stekas segment stack
        db 256  dup(0)
stekas ends        
                   
duomenys segment  
         a db 10
         b db 3
         c db 5
         du db 2
         rez dw 0
duomenys ends
             
programa segment
         assume ds:duomenys, ss:stekas, cs:programa
 start: mov ax, duomenys
        mov ds,ax
        mov ax,0
        mov al,a
        mul du
        mov bx,ax
        mov ax,0
        mov al,b
        mul c 
        add ax,bx
        mov rez,ax
        mov ah,4ch
        int 21h 
programa ends   
end start       
                