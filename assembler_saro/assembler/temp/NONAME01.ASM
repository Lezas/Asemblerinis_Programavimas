Stekas Segment STACK
DB 256 DUP (?)
Stekas ends

Duomenys SEGMENT
a db 127
b db 13
c db 0
Duomenys ends


Programa SEGMENT
assume CS:Programa,DS:Duomenys,SS:Stekas

START:
MOV AX,Duomenys
MOV DS,AX
       
MOV AH,a
ADD AH,b

       
MOV c,AH 

mov AH,4Ch
INT 21h           
           
Programa ends
END START