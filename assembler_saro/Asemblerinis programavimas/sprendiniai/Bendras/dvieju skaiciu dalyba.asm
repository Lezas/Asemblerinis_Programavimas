;dvieju skaiciu dalyba
stekas segment stack                 
db 256 dup(0)                 
stekas ends                                               
duomenys segment                       
a db 14
b db 3
rezultatas db ?,'$'
rezultatas1 db ?, '$'
pran db 'dvieju skaiciu dalyba',13,10,'$'
pran1 db '  liekana ','$'
duomenys  ends
programa  segment
assume cs:programa, ds:duomenys, ss:stekas
start:    mov ax,duomenys
mov ds,ax
mov ax,0002h
int 10h
mov AL,a
div b
ADD AH,30h
MOV rezultatas,AH
ADD AL,30h
MOV rezultatas1,AL
mov AH,09h
LEA DX,pran
INT 21h
mov AH,09h
LEA DX,rezultatas1
INT 21h
mov AH,09h
LEA DX,pran1
INT 21h
mov AH,09h
LEA DX,rezultatas
INT 21h
;laukimas
mov ah, 07h
int 21h
MOV ah,4Ch
INT 21h
programa  ends
end start
