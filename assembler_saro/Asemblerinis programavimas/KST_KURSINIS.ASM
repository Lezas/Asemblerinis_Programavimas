;
; Kestutis Stankevicius, II-06/3
;
; Asemblerinis programavimas, Kursinis darbas.
; 
; 2009
;
; Login/Logout
;

; Steko segmentas
stekas SEGMENT STACK
 DB 256 DUP(0) ; isskiriame atmintyje 256 baitus
stekas ENDS

; konstantos
CR EQU 13
LF EQU 10

; Duomenu segmentas
duomenys SEGMENT
 ; aprasome kintamuosius
 ivsr      DB 5, ?, 5 DUP(?)
 
 titulinis DB CR, LF, ' ASM Kursinis darbas - Login ',
           DB CR, LF, ' Atliko: Kestutis Stankevicius, II-06/3',
           DB CR, LF, ' --------------------------------------', CR,LF,'$'

duomenys ENDS

; Programos segmentas
programa SEGMENT
 ASSUME CS:programa, DS:duomenys, SS:stekas

START:
; pradzia
MOV AX, duomenys
MOV DS, AX

; isvalyti ekrana
MOV AX, 0002h
INT 10h

; titulinis pranesimas
MOV AH, 09h
LEA DX, titulinis
INT 21h


; paspausti bet koki klavisa
MOV AH, 07h
INT 21h

PABAIGA:
; iseiti is programos
MOV AH, 4ch
INT 21h

programa ENDS

END START