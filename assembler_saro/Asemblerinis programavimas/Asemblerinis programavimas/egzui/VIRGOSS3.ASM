;---Formule: X=(a^2+3bc)/c
stekas segment stack      
        db 256  dup(0)
stekas ends               
                          
duomenys segment          
         a db 9          
         b db 3           
         c db 5           
         trys db 3        
         rez dw 0         
duomenys ends             
                          
programa segment          
         assume ds:duomenys, ss:stekas, cs:programa
 start: mov ax, duomenys  
        mov ds,ax         
        mov ax,0 
        mov al,a          
        mul a 
        mov bx,ax         
        mov ax,0
        mov al,b          
        mul trys 
        mul c
        add ax,bx
        mov bx,0                          
        mov bl,c                          
        div bx                            
        mov ah,dl ;liekana is dl siunciama i ah 
        mov rez,ax
        mov ah,4ch
        int 21h 
programa ends   
end start       
                