 stekas segment stack
        db 256 dup (?)
stekas ends

duomenys segment
        uzduotis db 'Programa randa masyvo max ir min',10,13
                db 'bei apskaiciuoja ju suma',10,13,'$'
        t1      db 'max=','$'
        t2      db 'min=','$'
        t3      db 'max+min=','$'
                x db 0,1,2,5,7,4 
                xd db 6
                max db ?,10,13, '$'
                min db ?,10,13, '$'
                suma db ?, 10,13, '$'
duomenys ends

programa segment
assume cs:programa, ss:stekas, ds:duomenys
start:
mov ax, duomenys
mov ds, ax

;ekrano valymas
mov ax, 02h
int 10h

;uzduoties isvedimas
mov ah, 09h
lea dx, uzduotis
int 21h

;skaiciavimai
mov dx, 0
mov si, 0
mov cl, xd
lea bx, x  
mov al, 0
max1:       
cmp [bx], al
jle max2
mov al, [bx]    
max2:       
inc bx      
loop max1
mov max, al

;skaiciavimai2
mov dx, 0
mov al, 0
mov si, 0
mov cl, xd
lea bx, x
min1:
cmp [bx], al
jge min2
mov al, [bx]
min2:
inc bx
loop min1
mov min, al

;sudetis
mov al, max
add al, min
mov suma, al

;isvedimas
mov ah, 09h
lea dx, t1
int 21h

mov ah, 09h
add max, 30h
lea dx, max
int 21h

mov ah, 09h
lea dx, t2
int 21h 

mov ah, 09h
add min, 30h
lea dx, min
int 21h

mov ah, 09h
lea dx, t3
int 21h
mov ah, 09h
add suma, 30h
lea dx, suma
int 21h

;ekrano uzlaikymas
mov ah, 07h
int 21h
;grizimas i DOS'a
mov ah, 4ch
int 21h

programa ends
end start