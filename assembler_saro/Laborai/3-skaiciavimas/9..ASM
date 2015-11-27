stekas segment stack
        db 256 dup(0)
stekas ends    
               
duomenys segment                                        
                                                       
        pran1 db 'Laboratorinis Nr.2 Levaldas Sukovas II-2/3',13,10
              db 'Programa skaiciuoja a+b+c ir a+b-c',13,10,'$'      
        pran2 db 'a+b+c = $'                                         
        pran3 db 'a+b-c = $'                                         
        pran4 db '',13,10,'$'                                        
                                                                     
        a db 1
        b db 2                                                       
        c db 3                                                       
        d db ?,'$'                                                                                                          
        e db ?,'$'
                                                                     
duomenys ends                                                        
                                                                     
programa segment                                                     
        assume cs:programa, ds:duomenys, ss:stekas                   
                                                                     
start:                                                               
                                                                     
        mov ax,duomenys                                              
        mov ds, ax                                                   
                                                                     
        mov ax,0002h                                                 
        int 10h                                                      
                                                                     
        mov ah,09h                                                   
        lea dx, pran1                                                
        int 21h                                                      
        mov ah,09h                                                   
        lea dx, pran4                                                
        int 21h                                                      
                                                                     
;SKAICIAVIMAI                                                        
;Sudetis                                                             
        mov ah,a                                                     
        add ah,b                                                     
        add ah,c                                     
                        
        mov d,ah                                                     
        add d,30h                                                    
                                                                     
        mov ah,09h                                                   
        lea dx,pran2                                                 
        int 21h                                                      
                                                                     
        mov ah,09h                                                   
        lea dx,d                                                     
        int 21h                                                      
                                                                     
;Atimtis                                                             
        mov ah,a                                                     
        add ah,b                                                     
        sub ah,c                                                     
        mov e,ah                                                     
        add e,30h
             
        mov ah,09h
        lea dx,pran4
        int 21h
             
        mov ah,09h
        lea dx,pran3
        int 21h
        
        mov ah,09h
        lea dx,e
        int 21h
        
;PABAIGA     
        mov ah, 07h
        int 21h
        mov ah,4ch
        int 21h         
         
programa ends
end start