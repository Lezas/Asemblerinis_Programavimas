stekas segment stack                 
      db 256 dup (0)
ends stekas                                  
                                             
duomenys segment                             
         sk db 0     
         rez db 3 dup (0),'$'
         desimt db 10
         skaicius db 13,10,'Ivestu simboliu skaicius = ','$'       
         pran1 db 13,10,'Iveskite koki nors teksta',13,10,'$'
         pran2 db 'Ivestas tekstas:',13,10,'$'
         kazkas db 255,?
         tekstas db 255 dup ('*'),'$'        
         pran3 db 13,10,'Ivestas tekstas skaitant is kito galo:',13,10,'$'
         zodis db 255 dup ('*'),'$'          
                                             
ends duomenys                                
                                             
programa segment                             
         assume ds:duomenys, ss:stekas, cs: programa
 start: mov ax,duomenys                      
        mov ds,ax                            
                                             
        mov ax,0002h ;ekrano valymas                      
        int 10h   
        
        mov ah,09h   ;prasymas teksto ivedimui
        lea dx,pran1                         
        int 21h                              
                                               
        mov ah,0Ah  ;ivedamas tekstas        
        lea dx,kazkas                        
        int 21h                              
                                             
        mov ax,0002h  ;ekrano valymas                     
        int 10h  
                 
        ; kursoriaus nustatymas i ekrano viduri
        mov ah,02
        mov bh,00
        mov dh,5 
        mov dl,42
        int 10h                            
                                               
        mov ah,09h     
        lea dx,pran2                         
        int 21h                              
        ;$ zenklo vietos nustatymas          
        mov cx,0                             
        mov cl,kazkas+1 
        mov sk,cl      
        inc cx         
        mov bx,0                             
        lea bx,tekstas                      
        add bx,cx   ;sudeda adresus          
        mov dl,'$'                           
        mov [bx],dl                          
        ;rodo teksta   
        mov ah,09h       ;spausdina ivesta teksta                    
        lea dx,tekstas  
        int 21h        
               
        mov ah,09h ; isveda simboliu skaiciu
        lea dx,skaicius
        int 21h        
                       
        ; simboliu skaiciaus isvedimas
        mov ax,0       
        mov al,sk      
        mov cx,3            
        mov bx,0       
        lea bx,rez+2   
   LL:  div desimt     
        add ah,30h     
        mov [bx],ah    
        mov ah,0       
        dec bx         
        loop LL  
               
        mov ah,09h
        lea dx,rez
        int 21h
        
         ; Turi isvesti teksta atvirksciai
        mov ah, 09h    
        lea dx,pran3   
        int 21h        
                            
        lea bx,tekstas 
        mov dl,sk
        dec dx
        lea si,zodis[dx]   ;  lea si,zodis+27
        mov cx,0       
        mov cl,sk      
        
    L:  mov al,[bx]    
        mov [si],al    
        inc bx         
        dec si         
        loop L         
                            
        mov ah,09h ; isveda zodi
        lea dx,zodis   
        int 21h        
                       
        mov ah,4ch
        int 21h        
ends programa                               
 end start 