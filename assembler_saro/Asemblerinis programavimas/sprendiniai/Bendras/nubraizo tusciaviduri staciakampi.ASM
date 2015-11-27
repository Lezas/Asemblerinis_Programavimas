stekas segment stack                 
db 256 dup(0)                        
stekas ends                                 

duomenys segment                                                             
       pranesimas db 'Programa suformuoja tusciaviduri staciakampi',10,13 
                  db 'is pasirnkto simbolio pagal uzduotus parametrus',10,13  
                  db 'Programa sukure ii-23 grupes '                     
                  db 'studentas Vaidas Zdanys ',10,13,'$'
          pabaiga db '...spauskite bet kuri klavisa...','$'                                                              
         skaicius db 3,?,3 dup(?)
                s db 2,?,2 dup(?)
           plotis db ?                                      
          aukstis db ?                                      
         simbolis db ?,'$'                                  
           tarpas db ' ','$'                                
            kitas db ?                                      
         aukstis2 db ?                                      
          plotis2 db ?                                      
             jump db 10,13,'$'
            pran1 db 'Iveskite ploti (ne didesni negu 80): ','$'
            pran2 db 'Iveskite auksti (ne didesni 24): ','$'
            pran3 db 'Pasirinkite simboli: ','$'
         uzklausa db 'Jei norite kartoti programa,spauskite bet kuri klavisa',10,13
                  db 'Iseiti - ESC'                         
                  db 10,13,'$'
                v db 0                                           
            error db 'Klaida! Turite ivesti skaiciu!',10,13,'$'
              daug10 db 10                                  
              d10 dw 10                                     
                k dw ?                                      
                a db ?,'$'                                  
duomenys ends                                                                        
programa segment                                                                     
        assume cs:programa, ds:duomenys, ss:stekas                                   
        start:                                                                       
               mov ax, duomenys                                                      
               mov ds, ax                                                            
                                                                                     
               mov ax,0002h                      
               int 10h                           
               mov ah,09h                        
               lea dx,pranesimas                 
               int 21h                           
      pradzia:                                   
               mov ah,09h                        
               lea dx,pran1                                                          
               int 21h                                                               
               call ivedimas                       
                                                   
               cmp al,80        ;                   
               jg pradzia        ;    ar geras plotis
                                                                   
               mov plotis,al                           
                                                                  
      klaida1: mov ah,09h                              
               lea dx,pran2                            
               int 21h                                 
               call ivedimas                           
                                                       
               cmp al,24         ;                     
               jg klaida1        ;    ar geras aukshtis
                                                   
               mov aukstis,al                       
                                                                 
               mov ah,09h                                                            
               lea dx,pran3                         
               int 21h                              
               mov ah,0Ah                           
               lea dx,s                             
               int 21h                              
               mov bl,s[2]                          
               mov simbolis,bl                      
                                
               call next                                     
               mov bl,plotis
               mov bh,aukstis                    
                                                 
               cmp plotis,3                      
               jl  spec                          
               cmp aukstis,3                     
               jl spec                           
               jmp norm                          
                    spec: 
                          cmp plotis,80    ;
                          jne ok           ;    ar 80?
                          mov v,1          ;                
                      ok: mov cl,aukstis
                    zym2: mov kitas,cl           
                          mov cl,plotis          
                    zym1: call simb              
                          loop zym1              
                          call next              
                          mov cl,kitas           
                          loop zym2              
                          jmp zym3               
                                                 
        norm:  sub plotis,2                      
               sub aukstis,2                        
                                                    
               cmp plotis,78    ;                
               jne ok1          ;    ar 80?      
               mov v,1          ;                
          ok1:                                   
               mov ch,0                             
               mov cl,bl                            
           z3: call simb                            
               loop z3                              
                                                                                     
               call next                            
                                                     
               mov cl,aukstis
           z1: mov kitas,cl                         
               call simb                            
                                                  
               mov cl,plotis                        
           z2: mov ah,09h                           
               lea dx,tarpas                        
               int 21h                              
               loop z2                              
                            
               call simb                            
               call next                            
               mov cl,kitas                         
               loop z1                              
                                                    
               mov cl,bl                                                                                     
           z4: call simb                            
               loop z4                              
;pabaiga                                                                             
               call next                        
        zym3:  mov v,0
              ; mov ah,02h                                                            
              ; mov bh,00h                                                            
              ; mov dh,18h                                                            
              ; mov dl,00                                                             
              ; int 10h                                                               
               mov ah,09h                                                            
               lea dx,pabaiga                                                        
               int 21h                                                               
                                                                                     
               mov ah,07h                           
               int 21h                              
                                                
               mov ax,0002h
               int 10h                          
                                                
               mov ah,09h                  ;    
               lea dx,uzklausa                  
               int 21h                          
                                                    
               mov ah,08h                       
               int 21h                          
              ;uzklausa
               cmp al,1Bh                       
               je pab                           
               mov ax,0002h                     
               int 10h                          
               jmp far ptr pradzia         ;    
                                                
      pab:     mov ax,0002h                     
               int 10h                          
                                                
               mov ah,4ch                                                            
               int 21h                                                               
                                                    
               simb proc                            
               mov ah,09h                           
               lea dx,simbolis                      
               int 21h                              
               ret                                  
               endp simb                            
                                                    
               next proc                            
               cmp v,1                          
               jne zz5                          
               ret                              
          zz5: mov ah,09h                       
               lea dx,jump                          
               int 21h                                                                      
               ret                                  
               endp next                            
                                                    
               isvedimas proc                       
               mov k,0                                                               
               mov dx,0                                                              
         zz1:   div d10                                                               
               push dx                                                               
               inc k                                                                 
               mov dx,0                                                              
               cmp ax,0                                                              
               jne zz1                                                                
                                                                                     
               mov cx,k                                                              
          zz2:  pop dx                                                                
               mov a,dl                                                              
               add a,30h                                                             
               mov ah,09h                                                            
               lea dx,a                                                              
               int 21h                                                               
               loop zz2                                                               
               ret                                                                   
               endp isvedimas                                                        
                                                    
               ivedimas proc                        
               mov ah,0Ah                           
               lea dx,skaicius                      
               int 21h                              
                                                    
               call next                            
               mov ah,0                             
                                                    
               cmp skaicius[2],48          ;
               jl zyme1                    ;
               cmp skaicius[2],57          ;
               jle zyme2                   ;
         zyme1:                            ;         ar skaicius?
               mov ah,09h                  ;
               lea dx,error                ;
               int 21h                     ;
               jmp far ptr pradzia          ;
         zyme2:                            ;
               sub skaicius[2],30h                  
               mov al,skaicius[2]                   
                                                    
               cmp skaicius[1],1                    
               je zz4                               
                                                    
               mov ch,0           
               mov cl,skaicius[1] 
               sub cl,1           
               mov si,3           
          zz3: mul daug10         
                                   
               cmp skaicius[si],48         ;
               jl zyme11                    ;
               cmp skaicius[si],57         ;
               jle zyme21                   ;
        zyme11:                            ;         ar skaicius?
               mov ah,09h                  ;
               lea dx,error                ;
               int 21h                     ;
               jmp far ptr pradzia          ;
        zyme21:                            ;
                                   
               sub skaicius[si],30h
               add al,skaicius[si] 
               inc si              
               loop zz3            
         zz4:  ret                 
               endp ivedimas         
                                   
               programa ends                                                         
               end start                                                             
                     