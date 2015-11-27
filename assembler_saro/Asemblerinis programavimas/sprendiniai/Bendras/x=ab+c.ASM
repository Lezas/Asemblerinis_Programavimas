stekas segment stack
db 256 dup (0)
stekas ends
duomenys segment
a db 2
b db 3
c db 2
rezultatas db ?, '$'
pavarde db 'vilkelyte neringa', 13, 10
        db 'uzduotis:a*b+c',13,10
db 'rezultatas', '$'
duomenys ends
programa segment
assume cs:programa, ds:duomenys, ss:stekas
start:
mov ax, duomenys
mov ds, ax
mov al, a
mov ah, 0
mul b
add al, c
add al, 30h
mov rezultatas, al

mov ah,9
lea dx, pavarde
int 21h
mov ah,9
lea dx, rezultatas
int 21h
; laukimas
mov ah, 07h
int 21h
mov ah, 4ch
int 21h
programa ends
end start