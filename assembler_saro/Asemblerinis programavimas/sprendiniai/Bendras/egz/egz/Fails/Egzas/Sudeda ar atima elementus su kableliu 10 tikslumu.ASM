 .386     
 stekas segment stack use16
                db 256 dup (?)
stekas ends
          
cr equ 13 
lf equ 10 
          
duomenys segment use16
          
a dq -3.34 
b dq 15.567895 
desimt dd 10
ats db 10 dup (0), cr, lf, '$'
tikslumas dq 100.0
suma dd 0 
duomenys ends
          
prg segment use16
assume cs:prg,ds:duomenys,ss:stekas
          
start:    
     mov ax, duomenys
     mov ds, ax
          
     mov ax, 0002h  ; ekrano valymas
     int 10h                
; komprocesoriaus darbas
fld a     
fld b     
fadd      
fmul tikslumas
          
     fistp suma ; issaugomas rezultatas atmintyje
     mov eax, suma
     mov edx, 0
     mov di, 10
desimtaine:  
     div desimt
     add dl, 30h
     mov ats[di], dl
     mov dx, 0
 ;     xor dx, dx
     cmp al, 0
     je pabaiga
     dec di  
     cmp di, 8
     je kablelis
     jmp desimtaine
kablelis:          
     mov ats[di],  ','
     dec di        
     jmp desimtaine
                   
pabaiga:           
     mov ah, 09h   
     lea dx, ats   
     int 21h       
                   
     mov ah, 07h   
     int 21h       
                   
     mov ah, 4ch   
     int 21h       
                   
prg ends           
end start 