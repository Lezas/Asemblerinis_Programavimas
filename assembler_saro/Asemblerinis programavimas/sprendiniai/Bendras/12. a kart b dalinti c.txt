
 
  ; Giedrius Jonauskas II-33
  ;(a*b)/c      
 stekas segment stack
 db 256 dup (?)   
 stekas ends      
 duomenys segment 
;a db 5            
b db 2,? 
c db 2,?

a db 2, ?
t1 db '                               (a*b)/c',10,10,13,'$'
t22 db 'iveskite a reiksme' ,10,10,13,'$'
t23 db 'iveskite b reiksme' ,10,10,13,'$'
t24 db 'iveskite c reiksme', 10,10,13,'$'
t2 db ' sveikoji dalis' ,10,10,13, '$' 
t3 db 'liekanos dalis',10,10,13, '$'
d db 0,10,13, '$'    
e db 0,10,13, '$'        
 duomenys ends                                       
 programa segment                                    
 assume cs: programa, ds:duomenys, ss:stekas         
  start: mov ax, duomenys                            
         mov ds, ax                                  
         ;tekstinio ekrano ishvalymas                
         mov ax, 002h                                
         int 10h                                     
        ; uzduotis                               
         mov ah,09h                                  
         lea dx,t1                                   
         int 21h     

mov ah,09h
lea dx, t22
int 21h


 mov ah, 0Ah
       lea dx, a
       int 21h
       
 

mov ah,09h
lea dx,t23
int 21h

mov ah,0ah
lea dx,b
int 21h

mov ah,09h
lea dx,t24
int 21h
mov ah,0ah
lea dx,c
int 21h
                                
         ; skaiciavimai                              
         mov ax,0      
         mov al,a     
         mul b       
         div c    
         mov d,al 
         add d,30h
         mov e,ah
         add e,30h                
         ;spausdinimas
       mov ah, 09h
       lea dx,t2
       int 21h
                  
        mov ah,09h       
      lea dx,d    
      int 21h     
      
      
       mov ah, 09h
       lea dx, t3
       int 21h
       
      mov ah, 09h
      lea dx,e
      int 21h
          
      ;laukia klavisho paspaudimo
     mov ah, 07h  
     int 21h      
     ;pabaiga     
      mov ah,4ch  
      int 21h     
      programa ends
      end start