stekas segment stack
db 256 dup (?)
stekas ends

duomenys segment
masyvas   dw 1,-7,4,5,-2
rez       db 0,'$'
T         db 5 dup (0),'$'
uzduotis  db 'Isvesti neigiamu skaiciu kieki',13,10,'$'
ats       db 'Neigiamu skaiciu yra:','$'
neig      db '',10,13,'Skaiciai:','$'
duomenys ends

programa segment
assume cs:programa,ds:duomenys,ss:stekas
start:
mov ax,duomenys
mov ds,ax

mov ax, 02h
int 10h

mov ah, 09h
lea dx, uzduotis
int 21h

mov si, 0
mov cx,5
mov di,0
ciklas:  
cmp masyvas[si], 0
jl neigiamas
add si, 2
loop ciklas
neigiamas:
inc rez     
mov bx, masyvas[si]
neg bx
add bl, 30h
inc di
mov T[di],bl
mov T[di-1], '-'
inc di
add si, 2
loop ciklas      
         
mov ah, 09h
lea dx, ats
int 21h 
add rez, 30h
mov ah, 09h
lea dx, rez
int 21h

mov ah, 09h
lea dx, neig
int 21h
mov ah, 09h
lea dx, T
int 21h
         
mov ah, 07h
int 21h  
         
mov ah, 4ch
int 21h  
         
programa ends
end start