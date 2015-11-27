 stekas segment stack
        db 256 dup (?)                             
stekas ends                                          
                                                   
duomenys segment                    
                                    
pran1 db 'Programa apskaiciuos duoto reiskinio rezultata,',10,13,'$'
pran2 db 'Lygtis :   C=2ab',10,13,'$'     
ats   db 10,13, 'Atsakymas:   ','$'
pran3 db 10,13, 'Iveskite a: ','$'
pran4 db 10,13,'Iveskite b: ','$'
;klaida db 'Jusu ivestas skaicius netelpa viename baite...',10,13,'$'
desm db 10
desmw dw 10                          
a db '0','$'                                                         
b db '0','$'                        
du db 2                             
sveik db ?
duomenys ends                       
                                                               
programa segment                                                
   start:                                                      
   assume cs:programa, ds:duomenys, ss:stekas        
;    .386                                       
       ;paruosiam ds                                                        
        mov ax,duomenys                                           
        mov ds,ax                        
                                    
        call valymas                
        call pradzia                
        call ivedimas               
        call isvedimas              
        call pabaiga                
valymas:                            
       	  mov ax,0002h              
       	  int 10h                   
ret                                 
                                    
pradzia:                            
       ;kursoriaus perkelimas               
;          mov ah,02                  
 ;         mov bh,00                  
  ;        mov dh,5                  
   ;       mov dl,18                 
    ;      int 10h                        
;praneshimo ishvedimas              
          mov ah,09h                
          lea dx,pran1              
          int 21h                   
       ;kursoriaus perkelimas               
;          mov ah,02                  
 ;         mov bh,00                  
  ;        mov dh,7                  
   ;       mov dl,10                 
    ;      int 10h                   
;praneshimo ishvedimas              
          mov ah,09h                
          lea dx,pran2              
          int 21h                   
ret                                 
                                    
ivedimas:                                        
                                                           
    ;kursoriaus perkelimas          
;          mov ah,02                  
 ;         mov bh,00                  
  ;        mov dh,10                 
   ;       mov dl,05                 
    ;      int 10h                   
;praneshimo ishvedimas              
          mov ah,09h                
          lea dx,pran3              
          int 21h                            
                                           
        call funkcija                      
        mov a,bl                           
                                           
       ;kursoriaus perkelimas               
;          mov ah,02                  
 ;         mov bh,00                  
  ;        mov dh,11                      
   ;       mov dl,05                 
    ;      int 10h                   
;praneshimo ishvedimas              
          mov ah,09h                
          lea dx,pran4              
          int 21h                           
                                          
        call funkcija                    
        mov b,bl                          
                                    
ret                                       
                                          
funkcija proc                               
        xor ax,ax ; nunulinam ax          
        xor bx,bx ; nunulinam bx          
        xor cx,cx ; nunulinam cx          
                                          
        mov ah,08h ; ivedinesime pagal 08h komanda
        int 21h                           
                                          
        cmp al,13                   
        je pab                      
        cmp al,'-'                  
        je zen                      
        jmp plus                    
                                          
        ppp:                                      
        mov ah,08h                        
        int 21h                           
                                          
        cmp al,13                         
        je pab                            
        cmp al,'-'                  
        je zen                      
                                          
        plus:                              
        cmp al,'0'                  
        jb ppp ; FALSE                     
        cmp al,'9'                  
        ja ppp                            
                                          
        mov dl,al                          
        mov ah,02h                         
        int 21h                           
                                          
        sub al,30h                         
        mov dl,al                          
        mov al,bl                          
        imul desm                      
                                          
        jo error                          
        mov bl,al                          
        add bl,dl                         
                                          
        jo error                          
        jmp ppp                           
                                          
        zen:                               
        mov dl,'-'                         
        mov ah,02h                        
        int 21h                           
                                          
        min:                              
        mov ah,08h                        
        int 21h                           
                                          
        cmp al,13                         
        je pab                            
        cmp al,'0'                        
        jb min                            
        cmp al,'9'                        
        ja min                            
                                          
        mov dl,al                         
        mov ah,02h                        
        int 21h                           
                                          
        sub al,30h                        
        neg al                            
                                          
        mov dl,al                         
        mov al,bl                         
        imul desm                      
                                          
        jo error                          
        mov bl,al                         
        add bl,dl                         
        jo error                          
        jmp min                           
        error:                            
                                          
;        mov ah,02                         
 ;       mov bh,00                         
  ;      mov dh,19                         
   ;     mov dl,10                         
    ;    int 10h                           
                                          
;        mov ah, 09h                       
 ;       lea dx,klaida                 
  ;      int 21h                           
                                          
        jmp pabaiga                 
        pab:                        
        ret                               
funkcija endp                       
                                    
isvedimas:                          
        xor ax,ax                         
        xor bx,bx                         
                                          
        mov al,a                          
        cbw                               
        imul du                     
        cmp b,0h                    
        jnl cia                     
        neg b                       
        mov bl,b                    
        cbw                         
        imul bx                     
        jmp teig                    
        cia:                                  
        mov bl,b                    
        cbw                               
        imul bx                     
        jmp taa                     
        teig:                            
        neg ax                                  
        ;tikrinam                        
        taa:                             
        cmp ax,0000h                     
        jg sokti                         
                                          
        neg ax                            
        mov ats[14],2Dh                  
              
        sokti:                           
        mov si,ax
;        mov ah,02
 ;       mov bh,00                         
  ;      mov dh,19                         
   ;     mov dl,05                        
    ;    int 10h                           
                                          
        mov ah, 09h                       
        lea dx,ats                     
        int 21h       
           
        mov ax,si
        mov bx,0h                        
        mov cx,3
                                         
        cikl1:                           
        cmp ax,10                        
        jb maziau                        
        mov dx,0h                        
        div desmw                        
        push dx                          
        inc bx                           
        loop cikl1                       
                                         
        maziau:                          
        mov dx,ax                        
        push dx                          
        inc bx                           
                                         
        mov cx,bx 
        cikl2:    
        pop ax    
        mov bx,0h 
        mov bx,ax 
        add bx,30h
       ; mov ats[BP],bh
        mov dx,0h
        mov dx,bx
        mov ah,02h
        int 21h
        loop cikl2
                  
ret             
       
pabaiga:         
  ;kursoriaus perkelimas               
          mov ah,02                  
          mov bh,00                  
          mov dh,23
          mov dl,0
          int 10h
;laukia klaviso paspaudimo                              
        mov ah,07h         
        int 21h            
                           
;-grizhta i DOS                
          mov ah,4ch           
          int 21h              
programa  ends                 
          end start        
