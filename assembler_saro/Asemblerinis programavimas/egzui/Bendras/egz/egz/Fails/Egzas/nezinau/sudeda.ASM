;sudeda du skaicius 
stekas segment stack                                        
db 256 dup(?)                                               
stekas ends                                                 
                                                            
        duomenys segment                                    
        pranesimas db 'sudesime 2 skaicius',10,13,'$'
        rez db 'rezultatas',10,13,'$'
        a db 3                       
        b db 0  
        ats db ?, '$'                    
        duomenys ends                                       
                                                            
        programa segment                                    
        ASSUME es: programa, ds: duomenys, ss: stekas       
                                                            
                                                            
                                                            
        start:                                              
                                                            
                 mov ax,duomenys                            
                 mov ds,ax                                  
                                                            
                 mov ax,0002h ;ekrano isvalymas             
                 int 10h                                    
                                                            
                 mov ah,02h           ;kursoriaus nustatymas
                 mov dh,1             ;eilutes nr
                 mov dl,20            ; stulpelio nr
                 int 10h             
                                     
                 mov ah, 09h         
                 lea dx,pranesimas   
                 int 21h             
                                     
                                     
               mov bh,a              
               add bh,b                 
                    mov ah,09h
                    lea dx,rez
                    int 21h
                    add bh,30h
                    mov ats,bh
                    lea dx,ats
                    int 21h                 
                                     
                                     
                 mov ah, 07h         
                 int 21h
                        
                 mov ah, 4ch
                 int 21h
                 
        programa ends
        end start 