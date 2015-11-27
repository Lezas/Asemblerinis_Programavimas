stekas segment stack
db 256 dup (?)
stekas ends

duomenys segment
origpran db '$','samaduailetsupokeksikisap'
tekstpran db 10,13,26 dup (0)
duomenys ends

programa segment
assume cs:programa,ds:duomenys,ss:stekas

start:

mov ax,duomenys
mov ds,ax
                  
lea si,origpran+26
mov ah,'$'        
lea di,tekstpran+2

pradzia:
;sumazinam vienetu su dec(decrement)
dec si
cmp [si],ah
je spausd


mov al,[si]
mov [di],al

;padidinam vienetu su inc(incriment)
inc di
jmp pradzia

spausd:
mov [di], ah
;spausdinimas
mov ah,09h
lea dx, tekstpran
int 21h
mov ah,4ch
int 21h

programa ends
end start