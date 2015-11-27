stekas    segment stack          
          db 256 dup(0)          
stekas    ends           
;duomenu segmentas                    
duomenys  segment           
uzduotis db '',13,10,'Viktorija Briskmanaite, II-04/4',13,10
            db 'Uzduotis: (k*a*c-b)/b ',13,10
            db 'Press any key to continue...',10,13
            db '',13,10,'$'                        
 reisk db '',10,13  
       db '(k*a*c-b)/b=','$'                        
eilute db '',13,10,'$'
    rl db ' reiskinio liekana yra:','$'
   ska db 'Iveskite skaiciu a:','$'
   skb db 'Iveskite skaiciu b:','$'
   skc db 'Iveskite skaiciu c:','$'
   rez db 'Rezultatai: ',10,13
       db '',10,13    
       db 'k reiksme yra lygi: ','$'

;kintamuju aprasymas                     
   a db ?,'$'
   b db ?,'$'
   c db ?,'$'
   k db 2,'$'                                      
   d db ?,'$'
   e db ?,'$'
         
duomenys  ends                                     
                                  
;programos segmentas                              
programa  segment                                 
          assume cs:programa, ds:duomenys, ss:stekas
start:                                            
                                                  
;duomenu inicializavimas                          
mov ax,duomenys                                   
mov ds,ax                                         
                                                  
;ekrano isvalymas                                 
          mov ax,0002h            
          int 10h                                 
                                  
;praneshimo ishvedimas                            
          mov ah,09h                              
          lea dx,uzduotis                         
          int 21h                                 
                            
;laukiam kol paspaus klavisa          
          mov ah, 07h                    
          int 21h    
                     
; spausdinama k reiksme           
                                  
        mov ah,09h                
        lea dx,rez
        int 21h                   
                                  
        add k, 30h                
        mov ah,09h   
        lea dx,k     
        int 21h      
        sub k, 30h   
                     
        mov ah,09h   
        lea dx,eilute
        int 21h      
                                     
;duomenu ivedimas            
                             
        mov ah,09h          
        lea dx,ska
        int 21h                                   
                            
        mov ax, 0h                                               
        mov ah, 08h          
        int 21h      
        mov e, al
        sub al, 30h          
        mov a, al                    
        mov ah,09h                                
        lea dx,e
        int 21h              
                             
        mov ah,09h                                
        lea dx,eilute
        int 21h      
                     
        mov ah,09h   
        lea dx,skb
        int 21h                                   
                     
        mov ax, 0h                                               
        mov ah, 08h          
        int 21h      
        mov e, al
        sub al, 30h          
        mov b, al                    
        mov ah,09h                                
        lea dx,e
        int 21h      
                     
        mov ah,09h                                
        lea dx,eilute
        int 21h      
                     
        mov ah,09h   
        lea dx,skc
        int 21h                                   
                     
        mov ax, 0h                                               
        mov ah, 08h          
        int 21h      
        mov e, al
        sub al, 30h          
        mov c, al                    
        mov ah,09h                                
        lea dx,e
        int 21h      
                     
        mov ah,09h                                
        lea dx,eilute
        int 21h      
                     
                     
;skaiciavimai        
        ;(K*a*c-b)/b 
        mov ah,09h   
        lea dx,reisk
        int 21h                                   
        mov al, k    
        mul a        
        mul c                 
        sub al, b             
        div b        
        mov d,al              
        mov e, ah
        add d,30h    
                     
        mov ah,09h            
        lea dx,d              
        int 21h               
                              
        mov ah,09h   
        lea dx,rl
        int 21h                        
                     
        add e, 30h
        mov ah,09h   
        lea dx,e
        int 21h      
                     
        mov ah,09h   
        lea dx,eilute
        int 21h                                                                          
;dar karta laukia klaviso paspaudimo               
          mov ah, 07h                    
          int 21h    
;grizhta i dosa
          mov ah,4ch 
          int 21h    
programa  ends                           
          end start                      
