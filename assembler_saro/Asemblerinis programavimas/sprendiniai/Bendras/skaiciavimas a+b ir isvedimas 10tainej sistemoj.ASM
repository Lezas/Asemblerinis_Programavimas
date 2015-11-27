.386   
; Programa skaiciuoja a+b ir isveda desimtaineje sistemoje
stekas segment stack use16                                
db 256 dup (?)                                            
stekas ends                                               
                                                          
cr equ 13                                                 
lf equ 10                                                 
duomenys segment use16 
pran db 'Darba atliko : Vidas Razmislevicius II-3/6',10,13,'$'                                   
a dq -1.7                                                 
b dq 15.7                                                 
desimt dd 10                                              
ats db 10 dup (0),cr,lf,'$'                               
tikslumas dq 100.00                                       
suma dd 0                                                 
duomenys ends
       
prg segment use16
assume cs:prg, ds:duomenys, ss:stekas    
start:           
mov ax,duomenys  
mov ds,ax        
mov ax,002h      
int 10h           
                 
fld a     ; a reiksme uzkraunama i steka es       
fld b     ; b reiksme uzkraunama i steka es   
fadd                                       
fmul tikslumas                             
                                           
fistp suma ;isssaugomas rezultatas atmintyje
mov eax,suma                               
mov edx,0                                  
;xor edx,edx                               
mov di,10                                  
desimtaine:                                
div desimt                                 
add dl,30h                                 
mov ats[di],dl                             
mov dx,0                                   
;xor dx,dx       
cmp al,0         
je pabaiga       
dec di           
cmp di,8
je kablelis
jmp desimtaine
kablelis:
mov ats[di],','
dec di 
jmp desimtaine
pabaiga:
mov ah,09h
lea dx,pran
int 21h
mov ah,09h
lea dx,ats
int 21h 


mov ah,07h
int 21h

mov ah,4ch
int 21h
prg ends
end start