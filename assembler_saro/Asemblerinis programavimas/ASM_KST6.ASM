;
; Kestutis Stankevicius, II-06/3
; Asemblerinis programavimas
;
; 6 Auditorijos darbas:
;
; Ivedamas ir atvaizduojamas tekstas per viduri atvirksciai
;
stekas SEGMENT STACK
 DB 256 DUP (?) ; isskiriame atmintyje 256 baitus
stekas ENDS

duomenys SEGMENT
; aprasome kintamuosius
 ivsr       DB 25, 0, 25 DUP(' ')
 spsr       DB 25 DUP(' ')
 du         DB 2
 pranesimas DB 'Iveskite pavarde: ','$'

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

; pranesimas
MOV AH, 09h
LEA DX, pranesimas
INT 21h

; ivedimas
MOV AH, 0Ah
LEA DX, ivsr
INT 21h

; $ gale ivesto teksto
LEA DI, spsr
LEA SI, ivsr+2
MOV BL, ivsr+1
MOV BH, 0
ADD SI,BX ; adresas kur siusime $ zenkla

DEC SI ; sumazinam SI -1

; raidziu apkeitimas
MOV CL, ivsr+1
MOV CH, 0

ciklas:
	MOV BH, [SI]
	MOV [DI], BH
	DEC SI ; sumazinam SI -1
	INC DI ; padidinam DI +1
LOOP ciklas

MOV BH, '$'
MOV [DI], BH ; spausdinimo pabaiga

; skaiciuojam kur spausdinti
MOV AL, 80
MOV AH, 0
SUB AL, BL ; atimtis
DIV du
MOV DL, AL ; randam kur pradeti spausdinti
MOV DH, 12
MOV AH, 02 ; 12 eilute
MOV BH, 00 ; puslapio numeris
INT 10h  ; i paskaiciuota vieta pastatom zymekli spausdinimui

; spausdinimas
MOV AH, 09h
LEA DX, spsr
INT 21h

; paspausti bet koki klavisa
MOV AH, 07h
INT 21h

; iseiti is programos
MOV AH, 4ch
INT 21h

programa ENDS

END START