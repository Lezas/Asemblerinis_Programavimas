stekas segment stack   
       db 256 dup (0)  
ends stekas            
                       
t equ 13               
d equ 10               
                       
duomenys segment       
         aSritis db 10,?
         a db 7 dup (?),'$'
         bSritis db 10,?
         b db 7 dup (?),'$'
         pran1 db t,d,'Iveskite varda_','$'
         pran2 db t,d,'Programa sudare: ','$'
         prana db t,d,'Iveskite a= ','$'
         pranb db t,d,'Iveskite b= ','$'
         ats db t,d,'Atsakymas: a+b= ','$'
         kiek  db 20,?             
         vardas  db 20 dup ('*'),'$'
         desimt db 10
         rez db 5 dup (?),'$' 
ends duomenys                      
                                   
programa segment                   
    assume ds:duomenys,ss:stekas, cs:programa
 start: mov ax,duomenys            
        mov ds,ax                  
                                   
        mov ax,0002h ;ekrano valymas                      
        int 10h                     
                                    
        mov ah,09h   ;prasymas vardo ivedimui 
        lea dx,pran1  
        int 21h        
                                               
        mov ah,0Ah  ;ivedamas vardas   
        lea dx,kiek            
        int 21h        
                       
        mov ax,0002h  ;ekrano valymas                     
        int 10h        
                                               
        mov ah,09h   ;spausdina pranesima 
        lea dx,pran2      
        int 21h        
        ;$ zenklo vietos nustatymas
        mov cx,0       
        mov cl,kiek+1  
        inc cx         
        mov bx,0       
        lea bx,vardas  
        add bx,cx   ;sudeda adresus   
        mov dl,'$'     
        mov [bx],dl    
        ;rodo kas atliko                            
        mov ah,09h      
        lea dx,vardas   
        int 21h        
                       
        ;duomenu a apdorojimas
        mov ah,09h  ;a ivedimas
        lea dx,prana          
        int 21h               
        mov ah,0Ah    ;isimena a
        lea dx,aSritis          
        int 21h        
                  
        mov ax,0  
        mov bx,0  
        lea bx,aSritis+2
        sub aSritis+2,30h
        mov al,aSritis+2
        mov cx,0  
        mov cl,aSritis+1
        dec cx    
     L1: cmp cx,0 
        je baigtA 
        mul desimt 
        inc bx     
        sub byte ptr [bx],30h
        add ax,[bx]
        loop L1   
baigtA: mov a,al  
                  
        ;duomenu b apdorojimas
        mov ah,09h  ;b ivedimas
        lea dx,pranb          
        int 21h               
        mov ah,0Ah    ;isimena b
        lea dx,bSritis
        int 21h        
                  
        mov ax,0  
        mov bx,0  
        lea bx,bSritis+2
        sub bSritis+2,30h
        mov al,bSritis+2
        mov cx,0  
        mov cl,bSritis+1
        dec cx    
    L2: cmp cx,0  
        je baigtB 
        mul desimt 
        inc bx     
        sub byte ptr [bx],30h
        add ax,[bx]
        loop L2   
baigtB: mov b,al  
                  
        mov ax,0  
        mov bx,0  
        mov al,a  
        mov bl,b  
        add ax,bx 
                  
        ; rezultato isvedimas
        mov cx,5  
        mov bx,0    
        lea bx,rez+4
   L3:  div desimt
        add ah,30h
        mov [bx],ah 
        mov ah,0  
        dec bx    
        loop L3   
                  
        mov ah,09h
        lea dx,ats
        int 21h   
        mov ah,09h
        lea dx,rez
        int 21h
       
        mov ah,4ch
        int 21h             
ends programa              
 end start                 
                           
                           