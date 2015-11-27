stekas segment stack                                      
dw 256 dup(0)                                              
stekas ends                                                
cr equ 13                                                  
lf equ 10                                                  
                                                           
duomenys segment                                             
       pranesimas db 'Atliko: Vaidas Zdanys II-23',cr,lf
                  db cr,lf                 
                  db 'Programa: darbas su masyvo elementais',cr,lf,'$'
            pran1 db cr,lf,'6-to ir 9-to elementu sandauga: ','$'
            pran2 db cr,lf,'7-to ir 23-cio elementu suma: ','$'                           
            pran3 db 'Masyvo elementu suma: ','$'         
            pran4 db cr,lf,'Masyvo elementu vidurkis: ','$'
            pran5 db ' liekana ','$'                                         
          pabaiga db '...spauskite bet kuri klavisa...','$'
          masyvas dw 21,2,61,11,3,101,45,0,9,0,0,0,0,0,0,0,0,1,1,0,0,0,2,0,2
              d10 dw 10                                                          
              d25 dw 25                                                    
                a db ?,'$'                                                      
                k dw ?,'$'                                                      
              sum dw 0
          liekana dw 0                                                     
                                                                         
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
                                                    
              mov ah,09h                                                   
              lea dx,pran3                                                 
              int 21h                                                                  
                                                                           
              mov ax,0                                                          
              mov cx,25                                                    
              mov si,0                                                          
                                                                                    
              suma:                                                             
              add ax,masyvas[si]                                           
              add si,2                                                     
              loop suma                                                         
              mov sum,ax                                                   
              call isvedimas  ;suma                                                  
                                                                           
              mov ah,09h                                                   
              lea dx,pran4                                                 
              int 21h                                                      
                                                                           
              mov ax,sum              
              mov dx,0                
              div d25                 
              mov liekana,dx          
              call isvedimas ;vidurkis, be liekanos
                                                                           
              mov ah,09h                                                   
              lea dx,pran5                                                 
              int 21h                                
                                                     
              mov ax,liekana                         
              call isvedimas ;vidurkio liekana       
                                                                                
                                                     
               mov ah,09h                                                        
               lea dx,pran1                                                      
               int 21h                                                           
               mov si,10                             
               mov ax,masyvas[si]  ;6 elementas      
               mov si,16                             
               mov bx,masyvas[si]  ;9 elementas      
               mul bx                                
               call isvedimas                        
                                                     
               mov ah,09h                            
               lea dx,pran2                          
               int 21h                                                           
               mov si,12                             
               mov ax,masyvas[si]  ;7 elementas      
               mov si,44                             
               mov bx,masyvas[si]  ;23 elementas     
               add ax,bx                             
               call isvedimas                                 
                                                                                

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
                         