;
; Kestutis Stankevicius, II-06/3
; Asemblerinis programavimas
;
; 4 Auditorijos darbas:
;
; (a*2-c)*4 = ?
;
stekas SEGMENT STACK
 DB 256 DUP (?) ; isskiriame atmintyje 256 baitus
stekas ENDS

duomenys SEGMENT
; aprasome kintamuosius
 du     DB 2
 trys DB 3
 desimt DB 10
 a      DB 13
 b      DB 9
 c      DB 5
 rezult DB 3 DUP (' '), '$'

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

  

mov bl, 0
mov bl, a
add bl, b 
sub bl, c
mul trys 
mov al, 0
mov al, bl 
div du

 mov al, 0




; tvarkomes +1
DIV desimt
MOV rezult+1, AH
ADD rezult+1, 30h
; tvarkomes +0
MOV AH, 0
DIV desimt
MOV rezult, AH
ADD rezult, 30h

; atvaizduoti
MOV AH, 09h
LEA DX, rezult
INT 21h

; paspausti bet koki klavisa
MOV AH, 07h
INT 21h

; iseiti is programos
MOV AH, 4ch
INT 21h

programa ENDS

END START