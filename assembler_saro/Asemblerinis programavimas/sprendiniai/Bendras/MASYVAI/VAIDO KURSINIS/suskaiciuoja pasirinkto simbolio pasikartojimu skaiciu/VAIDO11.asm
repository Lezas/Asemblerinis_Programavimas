stekas segment stack                 
db 256 dup(0)                        
stekas ends                          
cr equ 13                            
lf equ 10                            
duomenys segment                                                             
       pranesimas1 db 'Programa ivestoje simboliu eiluteje suskaiciuoja ',cr,lf
                   db 'pasirinkto simbolio pasikartojimu skaiciu',cr,lf,'$'
       pranesimas db cr,lf,'Programa sukure ii-23 grupes '                 
                  db 'studentas Vaidas Zdanys ',cr,lf,'$'                  
          pabaiga db '...spauskite bet kuri klavisa...','$'                                                              
           eilute db 500 dup(?)                                            
         simbolis db 2,?,1 dup(?)                                          
                k dw ?                                                     
              d10 dw 10                                                    
                a db ?,'$'                                                 
            pran1 db 'Iveskite simboliu eilute',cr,lf,'$'                  
            pran2 db 'Iveskite viena simboli,'                             
                  db 'kurio pasikartojimu skaicius norite suskaiciuoti: ','$'
            pran3 db cr,lf,'Simbolio pasikartojimu skaicius: ','$'         
         uzklausa db cr,lf                                                 
                  db 'Jei norite kartoti programa,spauskite bet kuri klavisa',cr,lf
                  db 'Iseiti - ESC'                                        
                  db cr,lf,'$'                                             
            error db cr,lf,'Klaida!',cr,lf,'$'                              
duomenys ends                                                                        
                                                                                     
programa segment                                                                     
        assume cs:programa, ds:duomenys, ss:stekas                                   
        start:                                                                       
               mov ax, duomenys                                                      
               mov ds, ax                                                            
      pradzia: mov ax,0002h                                                
               int 10h                                                               
               
               mov ah,09h                                                  
               lea dx,pranesimas1                                          
               int 21h                                                     

               mov ah,09h                                                            
               lea dx,pran1                                                          
               int 21h                                                     
                                                                                     
               mov ah,3fh                                                            
               mov bx,0                                                              
               mov cx,500                                                  
               lea dx,eilute                                                         
               int 21h                                                               
                                                                                     
       klaida: mov ah,09h                                                  
               lea dx,pran2                                                          
               int 21h                                                               
                                                                                     
               mov ah,0Ah        
               lea dx,simbolis   
               int 21h           
                                
               mov bl,simbolis[2]
               cmp bl,' '     
               je ok          
               cmp bl,33      
               jl klaida1     
               cmp bl,127     
               jl ok          
                              
      klaida1: mov ah,09h     
               lea dx,error   
               int 21h        
               jmp klaida     
           ok:                
               mov si,0
               mov di,0
                                                                                     
       zyme2:  inc si                                                                
               cmp eilute[si-1],bl                                                   
               jne zyme1                                                             
               inc di                                                                
                                                                             
               jmp zyme2                                                             
       zyme1:                                                                        
               cmp eilute[si-1],13                                                   
               jne zyme2                                                             
                                                                                     
               mov ah,09h                                                            
               lea dx,pran3                                                          
               int 21h                                                               
               mov ax,di                                                             
               call isvedimas                                                        
;pabaiga                                                                             
               mov ah,09h                           
               lea dx,uzklausa                      
               int 21h                              
                                                    
               mov ah,08h                                                            
               int 21h                                                               
                                                                                     
               cmp al,1Bh                                                             
               jne pradzia                                                           
                              
               mov ah,09h     
               lea dx,pranesimas
               int 21h       
                      
               mov ah,02h                                                            
               mov bh,00h                                                            
               mov dh,18h                                                            
               mov dl,00                                                             
               int 10h                                                               
               mov ah,09h                                                            
               lea dx,pabaiga                                                        
               int 21h                                                               
               mov ah,07h
               int 21h
               mov ax,0002h                                                          
               int 10h                                                               
               mov ah,4ch                                                            
               int 21h                                                               
                                                                                     
               isvedimas proc                                                        
               mov k,0                                                               
               mov dx,0                                                              
         z1:   div d10                                                               
               push dx                                                               
               inc k                                                                 
               mov dx,0                                                              
               cmp ax,0                                                              
               jne z1                                                                
                                                                                     
               mov cx,k                                                              
          z2:  pop dx                                                                
               mov a,dl                                                              
               add a,30h                                                             
               mov ah,09h                                                            
               lea dx,a                                                              
               int 21h                                                               
               loop z2                                                               
               ret                                                                   
               endp isvedimas                                                        
                                                                                     
               programa ends                                                         
               end start                                                             
                     