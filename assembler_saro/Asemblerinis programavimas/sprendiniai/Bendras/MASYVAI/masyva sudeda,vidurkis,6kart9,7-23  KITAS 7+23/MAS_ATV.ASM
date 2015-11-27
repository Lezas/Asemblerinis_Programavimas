stekas segment stack                                      
dw 256 dup(0)                                              
stekas ends                                                
cr equ 13                                                  
lf equ 10                                                  
                                                           
duomenys segment                                             
       pranesimas db 'Atliko: Vaidas Zdanys II-23',cr,lf
                  db cr,lf                 
                  db 'Programa: darbas su masyvo elementais',cr,lf,'$'                                                               
              mas db 15,?, 15 dup(?)
                  db '$'  
             mas2 db 15 dup(?),'$'                   
             pabaiga db '...spauskite bet kuri klavisa...','$'     
                 kitas db 0,'$'   
                doleris db '$'  
duomenys ends                                                                   
                                                                                
                                                                                            
programa segment                                                                
        assume cs:programa, ds:duomenys, ss:stekas                              
        start:                                                                  
                                                                                
                                                                                         
              mov ax,00                                       
              mov bx,00                                       
                                                                                                                                        
              mov ax, duomenys                                
              mov ds, ax                                      
                                                                                
              mov ax, 0002h  ;ekrano                          
              int 10h        ;valymas                         
                                                              
              mov ah,09h                                      
              lea dx,pranesimas                               
              int 21h                                         
  ;pradzios pabaiga                                           
                                                              
              mov ah,0Ah                
              lea dx,mas                                      
              int 21h                                         
                                     
            ;  mov bl,mas[0]      
            ;  mov kitas,bl                          
            ;  add kitas,30h      
            ;  mov ah,09h                
            ;  lea dx,kitas             
            ;  int 21h                                                
                                                              
              mov cl,mas[1]       
              mov ch,0            
              mov si,2            
              mov di,cx
              mov al,doleris
              mov mas2[di+1],al
         cik:                     
              mov ah,mas[si]      
              add si,1            
              mov mas2[di],ah                                                
             ; mov kitas,ah       
              sub di,1            
              loop cik            
                                  
             ;  add di,1          
               add cx,1
         cik2: mov dl,mas2[di]    
               add di,1           
              ; mov kitas,dl            
               mov ah,02
              ; lea dx,kitas       
               int 21h            
                                  
              loop cik2                                                
  ;uzbaigimas                                                 
               mov ah,02h                                    
               mov bh,00h                                    
               mov dh,18h                                    
               mov dl,00                                     
               int 10h                                       
               mov ah,09h                                    
               lea dx,pabaiga           
               int 21h                  
                                                                                
               mov ah, 07h                                                      
               int 21h                                                          
                                                                                
              ; mov ax,0002h                                                     
              ; int 10h                                                          
                                                                                
               mov ah,4ch                                                       
               int 21h                                                          
                                                                                
                                                                                
               programa ends             
               end start              
                         