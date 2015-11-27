
;
; Mini kontrolinis darbas: x = (2ab+c) / (c-b)
;2(a+b-c)/3
stekas SEGMENT STACK
 DB 256 DUP (?) ; isskiriame atmintyje 256 baitus
stekas ENDS

CR EQU 13
LF EQU 10

duomenys SEGMENT
; aprasome kintamuosius
 ivsr     DB 25, 0, 25 DUP(' ')
 pra1     DB 'Programos Autorius: ','$'
 pra2     DB '', CR, LF
          DB ' ----------', CR, LF
          DB ' Rezultatas: x = (2ab+c) / (c-b)', CR, LF, ' ', CR, LF
          DB '  Sveikoji dalis: ', '$'
 pra3     DB '', CR, LF, ' ', CR, LF
          DB '         Liekana: ', '$'

 vard     DB 0 ; vardiklis

 rez_sv   DB 3 DUP (' '), '$'  ; sveika dalis
 rez_li   DB 3 DUP (' '), '$'  ; liekana

 dalyba   DB 4
 a        DB 2
 b        DB 3
 c        DB 5

 du       DB 2
 desimt   DB 10

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

; pranesimas1
MOV AH, 09h
LEA DX, pra1
INT 21H

; ivedimas
MOV AH, 0Ah
LEA DX, ivsr
INT 21h

; $ gale ivesto teksto
LEA DI, ivsr+2
MOV BL, ivsr+1
MOV BH, 0
ADD DI,BX ; adresas kur siusime $ zenkla
MOV BH, '$'
MOV [DI], BH ; spausdinimo pabaiga

; skaiciuojam kur spausdinti
MOV AL, 80
MOV AH, 0
SUB AL, BL ; atimtis
DIV dalyba
MOV DL, AL ; randam kur pradeti spausdinti
MOV DH, 2
MOV AH, 02 ; 2 eilute
MOV BH, 00 ; puslapio numeris
INT 10h  ; i paskaiciuota vieta pastatom zymekli spausdinimui

; skaiciavimai
; skaiciuojam vardikli vard=c-b
MOV AL, c
MOV AH, 0
SUB AL, b
MOV vard, AL
; skaiciuojam skaitikli 2ab+c / vard=c-b
MOV AL, du
MOV AH, 0
MUL a
MUL b
ADD AL, c
DIV vard
; kuriam rezultata
; issaugojam liekana
MOV rez_li, AH
MOV AH, 0
; sveika dalis
DIV desimt
MOV rez_sv+2,AH
ADD rez_sv+2,30h
MOV AH, 0

DIV desimt
MOV rez_sv+1,AH
ADD rez_sv+1,30h
MOV AH, 0

DIV desimt
MOV rez_sv,AH
ADD rez_sv,30h

; liekana
MOV AL, rez_li
MOV AH, 0

DIV desimt
MOV rez_li+2,AH
ADD rez_li+2,30h
MOV AH, 0

DIV desimt
MOV rez_li+1,AH
ADD rez_li+1,30h
MOV AH, 0

DIV desimt
MOV rez_li,AH
ADD rez_li,30h

; spausdinimas
MOV AH, 09h
LEA DX, ivsr+2
INT 21h

MOV AH, 09h
LEA DX, pra2
INT 21h

MOV AH, 09h
LEA DX, rez_sv
INT 21h

MOV AH, 09h
LEA DX, pra3
INT 21h

MOV AH, 09h
LEA DX, rez_li
INT 21h

; paspausti bet koki klavisa
MOV AH, 07h
INT 21h

; iseiti is programos
MOV AH, 4ch
INT 21h

programa ENDS

END START