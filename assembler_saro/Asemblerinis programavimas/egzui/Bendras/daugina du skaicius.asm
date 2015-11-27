;daugina du skaicius
stekas segment stack
db 256 dup(?)
stekas ends
;duomenu segmentas
duomenys segment
a dw 12
b dw 4
c dw 300
x dw ?,'$'
uzduotis db 'padaudinti skaiciai',13,10,'$'
duomenys ends
;programos segmentas
programa segment
assume SS:stekas, DS:duomenys, CS: programa
start:
mov AX, duomenys
mov DS, AX
;ekrano valymas
mov AX, 0002h
int 10h
;pranesimo isvedimas
mov AH, 09h
lea DX, uzduotis
int 21h
;skaiciavimas
mov AX,a
mul B
add ax,30h
mov x,AX
MOV AH,09h
LEA DX,x
INT 21h
mov ah,07h
int 21h
mov ah,4ch
int 21h
Programa ENDS
END START
