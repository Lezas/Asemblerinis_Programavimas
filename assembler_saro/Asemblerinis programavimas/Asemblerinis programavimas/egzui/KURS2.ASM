;---formule x=(a^2+b^2)*GrNr
stekas segment stack        
       db 256 dup(0)        
       ends stekas          
                            
duomenys segment            
         a db 15            
         b db 2             
         GrNr db 5
         rez dw 0  
duomenys ends      
                   
programa segment   
         assume ds:duomenys,ss:stekas,cs:programa
start: mov ax,duomenys
       mov ds,ax
             
       mov ax,0
       mov al,a    
       mul a 
       mov bx,0
       mov bx,ax   
       mov ax,0
       mov al,b
       mul b                                        
       add ax,bx                                    
       mul GrNr
       mov rez,ax ;sesioliktainej sistemoj rez = 479
               
       mov ah,4ch
       int 21h  
programa ends   
end start       
                      
                
       