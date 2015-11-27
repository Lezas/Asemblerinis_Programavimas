stekas segment stack
db 256 dup (?)
stekas ends
          
duomenys segment
uzduotis db 10,10,13,'Ernestas Zekas II-3/1','$'
uzduotis2 db 10,10,13,'Uzduotis: Sudeti 10 vienazenkliu, ivedamu is klav., skaiciu.','$'
uzduotis3 db 10,10,13,'Rezultata isvesti i ekrana.','$'
pran     db 10,10,13,'Iveskite skaicius:','$'
klaida1  db 'Ivestas neskaicius!','$'
ivedimas   db 11,?,11 dup (0),'$'
des      db 10
du       db 2
T        db 4 dup (0),'$'
duomenys ends
          
programa segment
assume cs:programa, ds:duomenys, ss:stekas
start:  
mov ax, duomenys
mov ds, ax

;ekrano valymas
mov ax, 02h
int 10h  
         
;isvedimas i ekrana uzduotis
mov ah, 09h
lea dx, uzduotis
int 21h  

;isvedimas i ekrana uzduotis2
mov ah, 09h
lea dx, uzduotis2
int 21h  

;isvedimas i ekrana uzduotis3
mov ah, 09h
lea dx, uzduotis3
int 21h 

;isvedimas i ekrana pran
mov ah, 09h
lea dx, pran
int 21h  
     
;ivedimas is klaviaturos
mov ah, 0ah             
lea dx, ivedimas            
int 21h                 
mov ax, 0
mov si, 2
mov cl, ivedimas[1] ; kiek ivesta simboliu antras elementas, cl skaitliukas
ciklas:  
cmp ivedimas[si],48 ; jei maziau neskaicius, jei daugiau gali but skaicius
jl klaida     
cmp ivedimas[si],57
jg klaida
sub ivedimas[si], 30h
add al, ivedimas[si]
add si,1 ; paimti kas antra skaiciu 
loop ciklas
         
lea bx, T+3
ciklas1: 
div des  
add ah, 30h
mov [bx],ah
mov ah, 0
dec bx   
cmp al, 0
jne ciklas1

mov ax, 02h
int 10h  
mov ah, 09h
lea dx, T
int 21h      
jmp pabaiga
klaida:
mov ax, 02h 
int 10h
mov ah, 09h
lea dx, klaida1
int 21h   
pabaiga:    
mov ah, 07h
int 21h

mov ah, 4ch
int 21h

programa ends 
end start