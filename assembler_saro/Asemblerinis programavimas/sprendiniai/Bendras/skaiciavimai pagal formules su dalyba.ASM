stekas segment stack
db 256 dup(?)
stekas ends
duomenys segment
pran db 'Darba atliko: Vidas Razmislevicius II-3/6',10,13,'$'
a dw -5
b dw 3
c dw 1
duomenys ends
programa segment
assume cs:programa, ds:duomenys, ss:stekas
start:
mov ax, duomenys
mov ds, ax
mov ax,02h
int 10h
;pirma formule su daugyba
mov ax, a
imul a
mov bx, ax
mov ax, b
imul b
add ax, bx
mov bx, 3
imul bx
imul c

;su dalyba
mov ax, a
imul a
mov bx, ax
mov ax, b
imul b
add ax, bx
mov bx, 3
imul bx
idiv c
mov ah,09h
lea dx,pran
int 21h
mov ah,07h
int 21h
;programos baigimas
mov ah, 4ch
int 21h
programa ends
end start