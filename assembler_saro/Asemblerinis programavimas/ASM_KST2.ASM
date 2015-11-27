;
;
;   a + b = x
;
stekas SEGMENT STACK
 DB 256 DUP (?) ; isskiriame atmintyje 256 baitus
stekas ENDS

duomenys SEGMENT
; aprasome kintamuosius
 a DB 3
 b DB 6
 x DB 0, '$'

duomenys ENDS

programa SEGMENT
 ASSUME CS:programa, DS:duomenys, SS:stekas

START:
; pradzia
MOV AX, duomenys
MOV DS, AX

; isvalyti ekrana
MOV AX, 0002h
INT 10h

; skaiciavimai
MOV AH, a
ADD AH, b
ADD AH, 30h

; atvaizdavimas
MOV x, AH
MOV AH, 09h
LEA DX, x
INT 21h

; paspausti bet koki klavisa
MOV AH, 07h
INT 21h

; iseiti is programos
MOV AH, 4ch
INT 21h

programa ENDS

END START