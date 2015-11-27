
stekas SEGMENT STACK
 DB 256 DUP (?) ; isskiriame atmintyje 256 baitus
stekas ENDS

CR EQU 13
LF EQU 10

duomenys SEGMENT
; aprasome kintamuosius
 ivsr     DB 4, ?, 4 DUP(?)
 pra1     DB CR, LF, 'Iveskite skaiciu a: ','$'
 pra2     DB CR, LF, 'Iveskite skaiciu b: ','$'
 pra3     DB CR, LF, ' '
          DB CR, LF, '  Rezultatas: a+b=','$'

 klaidpr  DB CR, LF, 'Klaida!'

 a        DB 0
 b        DB 0

 x        DB 3 DUP (' '), '$'

 desimt   DB 10

duomenys ENDS

programa SEGMENT
 ASSUME CS:programa, DS:duomenys, SS:stekas

; Procedura IVEDIMAS
Ivedimas PROC
  LEA DX, ivsr
  MOV AH, 0Ah
  INT 21h
 RET
Ivedimas ENDP

; Procedura KONVERTUOTI
Konvertuoti PROC

  MOV CL, ivsr+1 ; ciklu skaicius
  MOV CH, 0
  MOV AH, 0
  LEA SI, ivsr+2
  MOV BH, [SI]
  ;
  CALL Tikrinimas

  MOV AL, BH
  DEC CL
  CMP CL, 0
  JE Return

  ciklas: INC SI
          MOV BH, [SI]
          ;
          CALL Tikrinimas

          MUL desimt
          ADD AL, BH
          JO Klaida1
     LOOP ciklas
Return:
 RET
Konvertuoti ENDP

; Pocedura TIKRINIMAS
Tikrinimas PROC

  CMP BH, 30h
  JL Klaida1
  CMP BH, 39h
  JG Klaida1
  SUB BH, 30h
 RET
Tikrinimas ENDP

; I Klaida
Klaida1: JMP Klaida

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

; Ivedimas a
CALL Ivedimas
CALL Konvertuoti
MOV a, AL

; pranesimas2
MOV AH, 09h
LEA DX, pra2
INT 21H

; Ivedimas b
CALL Ivedimas
CALL Konvertuoti
MOV b, AL

; a+b
ADD AL, a ; a+b
JO Klaida

; kuriam rezultata
MOV x, AH
MOV AH, 0
; sveika dalis
DIV desimt
MOV x+2,AH
ADD x+2,30h
MOV AH, 0

DIV desimt
MOV x+1,AH
ADD x+1,30h
MOV AH, 0

DIV desimt
MOV x,AH
ADD x,30h

; pranesimas3
MOV AH, 09h
LEA DX, pra3
INT 21H

; spausdinimas
MOV AH, 09h
LEA DX, x
INT 21h

; sokam i Pabaiga
JMP Pabaiga

Klaida:

MOV AH, 09h
LEA DX, klaidpr
INT 21h

Pabaiga:
; paspausti bet koki klavisa
MOV AH, 07h
INT 21h

; iseiti is programos
MOV AH, 4ch
INT 21h

programa ENDS

END START