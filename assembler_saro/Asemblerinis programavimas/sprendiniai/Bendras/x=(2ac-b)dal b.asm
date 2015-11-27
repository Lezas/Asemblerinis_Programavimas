
stekas segment stack
db 256 dup(0)
stekas ends 
 
duomenys segment 
pran1 db 'Atliko: Viktorija briskmanaite, II-04/4',10,13,'$'
pran2 db 'spresime reiskini: (2*a*c-b)/b', 10,13
        db 'Iveskite kintamuju reiksmes', 10,13,'$'
pran3 db 'a=','$'
pran4 db 'b=','$'
pran5 db 'c=','$'
;pran6 db 'Duomenys sekmingai ivesti,',10,13
;      db  ' Noredami testi, spauskite bet kuri mygtuka', 10,13,'$'
pran7 db 'ATSAKYMAS:',10,13
      db '(2*a*c-b)/b=','$'
;pran8 db 'Liekana=','$'
   ats db ?,10,13,'$'      
  a db 0,10,13,'$'
  b db 0,10,13, '$'
  c db 0,10,13, '$'
  K db 2,10,13,'$'
  liekana db 0,'$'
   duomenys ends
             
  ;-----programos segmentas--------
  programa segment
           assume cs:programa, ds:duomenys, ss:stekas
                                           
  start:  
 ;---------- Inicializacija---------- 
   mov ax, duomenys                
           mov ds, ax                      
;-------ekrano valymas------------                           
            mov ax, 0002h                  
            int 10h                        
;--------pranesimo isvedimas---------                       
            mov ah, 09h                    
            lea dx, pran1                  
            int 21h                        
                                     
;------ antro pran isvedimas-------                                           
            mov ah, 09h                    
            lea dx, pran2                  
            int 21h                        
;--------duomenu ivedimas ir vaizdavimas ekrane-----------                                  
         ;---a-------                
            mov ah, 09h                    
            lea dx, pran3                  
            int 21h                        
            mov ah, 08h                  
            int 21h               
            mov a,al                       
            mov ah, 09h
           lea dx,a
            int 21h
        ;------b------     
          mov ah, 09h           
          lea dx, pran4
          int 21h
          mov ah,08h
          int 21h
          mov b,al
          mov ah,09h
          lea dx,b
          int 21h    
      ;------c--------       
           mov ah, 09h           
          lea dx, pran5
          int 21h
          mov ah,08h
          int 21h 
          mov c,al                         
          mov ah,09h 
          lea dx,c
          int 21h       
          mov ah,09h       
 ;--------6 pranesimo isvedimas---------                 
;          lea dx,pran6 
;          int 21h 
;           mov ah, 07h
;            int 21h   
;---------------Skaiciavimai---------
       sub a,30h                     
       sub b,30h                     
       sub c,30h                     
       
        mov al,K                          
        mul a                        
        mul c                        
        sub al,b                     
        div b                        
        mov ats,al                   
        add ats, 30h                 
        mov liekana,ah               
        add liekana,30h              
;-------------Atsakymo isvedimas------        
       mov ah, 09h                   
        lea dx, pran7                
        int 21h                      
                                                                          
        mov ah, 09h                  
        lea dx, ats                  
        int 21h                      
                                     
;        mov ah, 09h                  
;        lea dx, pran8                
;        int 21h                      
       
;        mov ah, 09h                  
;        lea dx, liekana              
;        int 21h                      
      
        mov ah,07h
        int 21h
 ;----------- griztam i DOS'a                 
            mov ah, 4ch
            int 21h        
                   
            programa ends
            end start
         