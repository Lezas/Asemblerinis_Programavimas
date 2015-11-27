;-----Formule: X=a+b+c
;---------steko segmentas-------
stekas segment stack            
       db 256 dup(?)  
       ends stekas    
                      
;-----duomenu segmentas-------                
duomenys segment      
         a db 5       
         b db 2       
         c db 4       
         rez dw 0     
duomenys ends         
                      
;-------programos segmentas----                  
programa segment      
         assume ds:duomenys,ss:stekas,cs:programa
start: mov ax,duomenys
       mov ds,ax      
       mov ax,0       
       mov al,a    
       add al,b   
       add al,c
       mov rez,ax
       mov ah,4ch
       int 21h
programa ends
end start
 

       