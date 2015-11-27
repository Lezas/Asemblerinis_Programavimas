stekas segment stack     
       db 256 dup(0)     
       ends stekas       
                         
duomenys segment         
         x db 1,2,1,2    
           db 3,4,2,9                                                 
           db 5,7,3,5    
           db 8,8,1,0      
           db 3,7,0,2                 
         rez db 3 dup (0),'$'
         desimt db 10
         pran db 13,10,'Masyvo elementu suma = ','$'
 duomenys ends                                        
                                                      
programa segment                                      
         assume ds:duomenys,ss:stekas,cs:programa     
start: mov ax,duomenys                                
       mov ds,ax                                      
                                                      
       mov ax,0002h ;ekrano valymas                   
       int 10h                                        
                                                                                                
       mov cl,20                                
       mov ax,0                                 
       mov bx,0                                 
       lea bx,x                                 
    L: add al,[bx]                              
       inc bx                                   
       loop L                                   
                                                
        ; rezultato isvedimas                   
        mov cx,3                                
        mov bx,0                                
        lea bx,rez+2                            
   L1:  div desimt    
        add ah,30h
        mov [bx],ah                             
        mov ah,0                                
        dec bx                                  
        loop L1                                 
                                                
        mov ah,09h
        lea dx,pran
        int 21h    
                   
        mov ah,09h 
        lea dx,rez 
        int 21h    
        
        mov ah,4ch
        int 21h               
programa ends                
end start                    
                             
                             
       