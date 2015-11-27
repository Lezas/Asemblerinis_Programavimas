;Steko segmentas

Stekas SEGMENT STACK
       DB 256 DUP (?)
Stekas ENDS

CR equ 13 ; pratraukimas
LF equ 10 ; eilutes pabaiga

Duomenys SEGMENT
PRAN     DB 'Sveiki, tai tu!',CR,LF
         DB 'Ponas?',CR,LF
         DB 'Pabaiga.',"$"
Duomenys ENDS

Programa SEGMENT
         ASSUME CS: Programa,DS: Duomenys,SS: Stekas
                
;Paruosiame duomenu segmento registra

START: MOV AX,Duomenys
       MOV DS,AX

;Pranesimo spauzdinimas

MOV AH,09h
LEA DX,Pran
INT 21h
MOV AH,4Ch
INT 21h
Programa ENDS
         END START