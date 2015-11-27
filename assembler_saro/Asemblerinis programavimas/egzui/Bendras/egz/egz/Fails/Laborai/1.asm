  ; Valerija Lialina II-3/3
  ;(b*b+c)/a      
 stekas segment stack
 db 256 dup (?)   
 stekas ends      
 duomenys segment 
a db 3            
b db 2            
c db 3        
d db 0,10,13,'$'
e db 0,10,13,'$'         
t1 db 'Sveikoji dalis:',10,13,'$'    
t2 db 'Liekana po dalybos:',10,13,'$'
t3 db '                              Formule: (b^2+c)/a',10,10,13,'$'              
 duomenys ends            
 programa segment 
 assume cs: programa, ds:duomenys, ss:stekas
  start: mov ax, duomenys
         mov ds, ax
         ;tekstinio ekrano ishvalymas
         mov ax, 002h
         int 10h   
        ; Pavadinimas  
         mov ah,09h       
         lea dx,t3    
         int 21h 
         ; skaiciavimai        
         mov ax,0      
         mov al,b      
         mul b    
         add al,c   
         div a    
         mov d,al 
         mov e,ah
         add e,30h    
         add d,30h                
         ;spausdinimas
       mov ah,09h       
      lea dx,t1    
      int 21h     
        mov ah,09h       
      lea dx,d    
      int 21h  
        mov ah,09h
      lea dx,t2    
      int 21h  
        mov ah,09h
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