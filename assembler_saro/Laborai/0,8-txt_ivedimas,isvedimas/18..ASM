stekas segment stack
        db 256 dup(0)
stekas ends         
                    
duomenys segment    
        pran1 db '***********************************************',13,10            
              db '*          Levaldas Sukovas  II-2/3           *',13,10
              db '* Programa leidzia ivesti varda pavarde grupe *',13,10
              db '***********************************************',13,10,10,'$'
        pran2 db ' Iveskite varda: $'
        pran3 db ' Iveskite pavarde: $'    
        pran4 db ' Iveskite grupe: $'      
        pran5 db 13,10,' Duomenys apie studenta: ',13,10,10,'$'
                                                       
        masvardas db '                    ',13,'$'     
        maspavarde db '                    ',13,'$'    
        masgrupe db '      ',13,'$'                    
                                                       
duomenys ends                                          
                                                       
NamuDarbas segment                                     
        assume cs:NamuDarbas, ds:duomenys, ss:stekas   
START:                                                 
        mov ax,duomenys                                
        mov ds,ax                                      
        mov ax,0002h                                   
        int 10h                                        
;Info isvedimas                                        
        mov ah,09h                                     
        lea dx,pran1                                   
        int 21h                                        
;Ivedimas                                              
        mov ah,09h                                     
        lea dx,pran2                                   
        int 21h                                        
        mov ah,3fh                                     
        mov bx,0                                       
        mov cx,21                                      
        lea dx,masvardas                               
        int 21h                                        
                                                       
        mov ah,09h                                     
        lea dx,pran3                                   
        int 21h                                        
        mov ah,3fh                                     
        mov bx,0                                       
        mov cx,21                                      
        lea dx,maspavarde                              
        int 21h                                        
                                                       
        mov ah,09h                                     
        lea dx,pran4                                   
        int 21h                                        
        mov ah,3fh                                     
        mov bx,0                                       
        mov cx,7                                       
        lea dx,masgrupe                                
        int 21h                                        
                                                       
        mov ah,09h                                     
        lea dx,pran5                                   
        int 21h                                        
        mov ah,09h                                     
        lea dx,masvardas                               
        int 21h                                        
        mov ah,09h                                     
        lea dx,maspavarde                              
        int 21h                                        
        mov ah,09h                                     
        lea dx,masgrupe                                
        int 21h
                                                                                       
;Pabaiga                                               
        mov ah,07h                                     
        int 21h                                        
        mov ah,4ch                                     
        int 21h                
                  
NamuDarbas ends   
end START         