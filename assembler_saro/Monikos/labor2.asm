;steko segmentas
stekas SEGMENT STACK
DB 256 DUP (?)
stekas ENDS

;CR equ 13 ; CR yra eilutes perkelimas i kita/ pratraukimas
;LF equ 10 ; LF eilutes pradzia

duomenys SEGMENT 
A DB 127
B DB 13
C DB 0
duomenys ENDS

programa SEGMENT
ASSUME CS:programa, DS:duomenys, SS:stekas
; paruosiame duomenu segmento registra

START: 	MOV AX, duomenys
	MOV DS, AX

	;persiusti A i AL
	MOV AL,A
	;persiusti B i BL
	MOV BL,B
	;sudedam skaicius
	ADD AL,BL
	;persiunciam rezultata
	MOV C,AL
programa ENDS
END START