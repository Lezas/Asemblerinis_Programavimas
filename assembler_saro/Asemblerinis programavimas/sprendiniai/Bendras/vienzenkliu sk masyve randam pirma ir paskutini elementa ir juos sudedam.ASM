 stekas segment stack
        db 256 dup (0)
stekas ends

duomenys segment
        uzduotis db 'Duotas vienzenkliu skaiciu masyvas', 10,13
                db 'Programa randa pirma ir paskutini elementa',10,13
                db 'Suskaiciuoja ju suma', 10,13,'$'
        t1      db 'Elementu suma: ','$'
        t2      db 'Pirmasis masyvo elementas a1=','$'
        t3      db 'Paskutinis masyvo elementas an=','$'
        masyvas db 7,5,3,4,9,3,4,8,9
        kiekis db 9
        suma db ?, 10,13, '$'
        ats db 4 dup (0),10,13,'$'
        ats2 db 4 dup (0), 10,13,'$'
        a1 db ? ,10,13,'$'
        a2 db ?, 10,13,'$'
        des db 10
duomenys ends

programa segment 
assume cs:programa, ds:duomenys, ss:stekas
start:
mov ax, duomenys
mov ds, ax

;ekrano valymas
mov ax, 02h
int 10h   
          
;uzduoties spauzdinimas
mov ah, 09h
lea dx,uzduotis
int 21h

;iesko pirmo ir paskutinio elemento
mov bx, 8
mov al, masyvas[bx]
mov a2, al
add a2, 30h

mov bx, 0
mov bl, masyvas[bx]
mov a1, bl
add a1, 30h

add al, bl
mov suma, al

mov cl, 0
mov ch, 0
mov bx, 0
mov cl, 2
lea bx, ats+3
mov al, suma
ciklas:
mov ah, 0
div des
add ah, 30h
mov [bx], ah
mov ah, 0
dec bx
loop ciklas

;isvedimas
mov ah, 09h
lea dx, t2
int 21h

mov ah, 09h
lea dx, a1
int 21h

mov ah, 09h
lea dx, t3
int 21h

mov ah, 09h
lea dx, a2
int 21h

mov ah, 09h
lea dx, t1
int 21h

mov ah, 09h 
lea dx, ats
int 21h

;ekrano uzlaikymas
mov ah, 07h
int 21h

;grizimas i DOS'a
mov ah,4ch
int 21h

programa ends
end start