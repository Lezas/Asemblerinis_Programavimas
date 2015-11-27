;komentaras
stekas segment stack
db 256 dup (?)
stekas ends
duomenys segment
pran db 'Darba atliko Vidas Razmislevicius II-3/6',10,13,7;10-perkelia zymekly 13-zymekly i kaire puse
db 'sveikas pasauli',10,0dh
db 'hellow world', '$'
duomenys ends
programa segment
assume cs:programa,ds:duomenys, ss:stekas
start:
;duomenu segmento formavimas
 mov ax, duomenys
mov ds, ax
;ekrano valymas
mov ax, 02h
int 10h ;pertraukimas per BIOS
;pranesimo isvedimas
mov ah, 09h
lea dx, pran
int 21h;pertraukimas per DOS
;ekrano uzlaikymas
mov ah, 07h
int 21h
;programos baigimas  
mov ah, 4ch
int 21h
 programa ends
end start