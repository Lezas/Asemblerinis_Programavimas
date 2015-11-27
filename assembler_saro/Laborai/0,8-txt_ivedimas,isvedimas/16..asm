stekas segment stack                        
        db 256 dup(0)                       
stekas ends                                 
                                            
duomenys segment                            
        pran1 db 'Laboratorinis darbas nr.8',10,13
              db 'Agne Katkute II-21',10,13,13,13,'$'
                                                                      
        pran2 db 'Iveskite savo varda ir pavarde: $'                                    
        pran3 db 10,13,'Iveskite grupe: $'                    
    masvardas db 50,?,50 dup(' ')            
         GrNr db 8,?,8 dup(' ') ,'$'                
           du db 2                                                    
                                                                      
duomenys ends                                                         
                                                                      
programa segment                                                      
        assume cs:programa, ds:duomenys, ss:stekas                    
START:                                                                
        mov ax,duomenys                                            
        mov ds,ax                                                  
          
        mov ax,0002h
        int 10h                                                    
                        
        mov ah,09h      
        lea dx,pran1    
        int 21h                                                    
                                                                                                                             
        mov ah,09h
        lea dx,pran2    
        int 21h
                                                                   
        ;Nuskaitymas                               
        mov ah,0Ah
        lea dx,masvardas
        int 21h
                             
        mov ah,09h                                                 
        lea dx,pran3                              
        int 21h                                                    
                                                                   
        ;Nuskaitymas                               
        mov ah,0Ah                                 
        lea dx,GrNr                                
        int 21h                                                                  
                                                   
        mov ax,0002h                               
        int 10h                                    
                                                   
       ;Grupes spausdinimas                        
        mov ah,02h                                 
        mov bh,00h                                 
        mov dh,11                                  
        mov dl,36                                  
        int 10h 
                                                                                      
        mov ah,09h                                 
        lea dx,GrNr+2
        int 21h                                    
                                                                                                    
; Vardo spausdinimas                                                                  
        mov al,80                                  
        sub al,masvardas+1                         
        mov ah,00                                  
        div du
                                                   
        mov ah,02                                  
        mov bh,00                                  
        mov dh,12                                
        mov dl,al                                  
        int 10h                                    
                                                   
       mov ah,00                                  
       mov al,masvardas+1                         
      mov si,2                                   
       add si,ax                                  
                                                   
        mov masvardas[si],'$'                      
                                                   
        mov ah, 09h                                
        lea dx, masvardas+2                       
        int 21h                                    
                                                   
                                                 
;Pabaiga                                               
        mov ah,07h                                     
        int 21h                                        
        mov ah,4ch                                     
        int 21h                
                           
programa ends              
end START         
