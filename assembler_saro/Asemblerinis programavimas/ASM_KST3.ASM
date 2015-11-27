;
; (a+b)-c = ?
;
stekas SEGMENT STACK
 DB 128 DUP (0) ; isskiriame atmintyje 128 baitus
stekas ENDS

duomenys SEGMENT
; aprasome kintamuosius
 a DB 5
 b DB 3
 c DB 1

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
MOV AL, a
ADD AL, b
SUB AL, c
ADD AL, 30h
; atvaizdavimas
MOV DL, AL
MOV AH, 02h
INT 21H

; paspausti bet koki klavisa
MOV AH, 07h
INT 21h

; iseiti is programos
MOV AH, 4ch
INT 21h

programa ENDS

END START