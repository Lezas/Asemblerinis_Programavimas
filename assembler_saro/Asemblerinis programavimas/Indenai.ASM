;
; Kestutis Stankevicius, II-06/3
; Asemblerinis programavimas
;
; Indenu uzdavinys su realiais skaiciais
;
stekas SEGMENT STACK
		DB 256 DUP(?)
stekas ENDS

CR EQU 13
LF EQU 10

duomenys SEGMENT
; aprasome kintamuosius
 crlf        DB CR,LF,'$'
 procent     DQ 1.03
 galut_suma  DD 0
 suma        DQ 24.0
 skaitliukas DW 375
 simtas      DQ 100.0
 desimt      DD 10
 ats         DB 11 DUP(?),'$'
 aut         DB CR,LF, ' Autorius: Kestutis Stankevicius II-06/3',CR,LF,LF,'$'
 dol         DB ' doleriu...',CR,LF,'$'
 pran        DB ' Indenai po tiek metu gaus labai daug pinigu',CR,LF,'$'

duomenys ENDS

programa SEGMENT
  ASSUME CS:programa, DS:duomenys, SS:stekas
.386
START:
; pradzia
MOV AX, duomenys
MOV DS, AX
; isvalome ekrana
MOV AX, 0002h
INT 10h
; ciklu skaicius
MOV CX, skaitliukas
fld suma
jcxz toliau
ciklas:
 fmul procent
 loop ciklas
;
toliau:
fmul simtas
fistp galut_suma
MOV eax, galut_suma
MOV edx, 0
MOV SI, 10
; konvertuojam
desimtaine:

DIV desimt
ADD DL,30h
MOV ats[SI], DL
DEC SI
XOR DX,DX
CMP AL, 0
JE pabaiga
CMP SI, 8
JE kablelis
JMP desimtaine
kablelis:
MOV ats[SI],2ch
DEC SI
JMP desimtaine
; pabaiga
pabaiga:
MOV AH, 09h
LEA DX, aut
INT 21h
MOV AH, 09h
LEA DX, pran
INT 21h
MOV AH, 09h
LEA DX, crlf
INT 21h
MOV AH, 09h
LEA DX, ats
INT 21h
MOV AH, 09h
LEA DX, dol
INT 21h
MOV AH, 4ch
INT 21h

programa ENDS

END START
