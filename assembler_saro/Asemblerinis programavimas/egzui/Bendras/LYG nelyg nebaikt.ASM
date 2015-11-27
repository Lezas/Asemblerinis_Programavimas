 Stekas segment stack
       db 256 dup(0)
       
Stekas ends
        
Duomenys segment
       PrLyginis db 'Duotasis skaicius yra lyginis' , '$'      
       PrNelyginis db 'Duotasis skaicius yra nelyginis' , '$'
       skaicius db 13, '$'
Duomenys ends            
                         
Programa segment         
assume ss: Stekas, ds: Duomenys, cs: Programa
start:                   
mov ax, Duomenys         
mov ds, ax               
                         
mov ax, 0002h  ; Del svaraus ekrano
int 10h                  
mov ax,0       
                         
mov al, skaicius 
shr ax, 1      	; dvejetaini koda perstumiame i desine per 1 pozicija
jnc lyginis	; jei dvejetainio skaiciuas paskutinis skaitmuo buvo vienas
		; tai CF (falg'as) igyja reiksme 1.  "jnc" tikriname ar CF=0, jei taip sokame...
                                                                     
mov ah, 09h                                                          
lea dx, PrNelyginis                                                  
int 21h                                                              
jmp pabaiga  ; sokame i pabaiga, kad neisvestu pranesimo apie lygini skaiciu.
                                                                     
lyginis:                                                             
mov ah, 09h                                                          
lea dx, PrLyginis                                                    
int 21h                                                              
                                                                     
pabaiga:                                                             
mov ah, 07h                                                          
int 21h  
mov ah, 4ch
int 21h  
             
Programa ends
         
end start       